 #encoding: utf-8
class CheckoutController < ApplicationController
  layout "simple"

  def index
		@cart = Cart.find(session[:cart_id])

    @personal_discount = 0

    if current_user
      #redirect_to billing_shipping
      @user = current_user
      @shipping_address = current_user.addresses.limit(1).where(:billing => 0).first
      @billing_address = current_user.addresses.limit(1).where(:billing => 1).first

      if session[:personal_discount] == @user.id
        @personal_discount = (@user.personal_discount_available > current_cart.total ? current_cart.total : @user.personal_discount_available)
      end

      render 'billing-shipping'
    else
      render 'register-login'
    end

  end

  def billing_shipping
    if current_user
      @user = current_user
      @shipping_address = current_user.addresses.where(:billing => 0).first
      @billing_address = current_user.addresses.where(:billing => 1).first
    else
      @user = User.new
      current_user = @user
    end

    render 'billing-shipping'
  end

  def payment

    unless current_user
      render 'billing-shipping'
    end

    data = params[:payment]

    shipping_address = current_user.addresses.where(:billing => 0).first
    billing_address = data[:same] == 0 ? current_user.addresses.where(:billing => 1).first : shipping_address

    shipping_address = Address.new(:user_id => current_user.id, :billing => 0) if shipping_address.nil?
    billing_address = Address.new(:user_id => current_user.id, :billing => 1) if billing_address.nil? && data[:same] == 0

    billing_address.city = data[:billing_city]
    billing_address.name = data[:billing_name]
    billing_address.zip = data[:billing_zip]
    billing_address.additional = data[:billing_additional]
    billing_address.save!

    shipping_address.city = data[:shipping_city]
    shipping_address.name = data[:shipping_name]
    shipping_address.zip = data[:shipping_zip]
    shipping_address.additional = data[:shipping_additional]
    shipping_address.save!

    shipping = shipping_address.id
    billing = data[:same] == 0 ? billing_address.id : shipping

    @order = Order.create(:shipping_address_id => shipping, :invoice_address_id => billing, :user_id => current_user.id, :status => "Feldolgozás alatt", :estimated_date => ((Time.now + 7.days).to_date))

    sum = 0

    current_cart.line_items.each do |li|
      @order.order_items << OrderItem.create(:product_id => li.product_id, :quantity => li.quantity, :price => li.product.full_price)
      sum = sum + li.product.full_price.to_i
    end

    @order.price = sum
    @personal_discount = 0

    if session[:personal_discount] == current_user.id
      @personal_discount = (current_user.personal_discount_available > current_cart.total ? current_cart.total : current_user.personal_discount_available)
    end

    session.delete(:personal_discount)

    @order.discount_used = @personal_discount
    @order.save
    session[:order_id] = @order.id

    render 'payment'
  end

  def thankyou

    unless session[:order_id]
      redirect_to '/cart'
    else
      # Payment types:
      # 1 - kártya
      # 2 - paypal
      # 3 - transfer
      @order = Order.find(session[:order_id])
      @order.payment_type = params[:payment_type]
      if @order.save
        LineItem.destroy_all(:cart_id => current_cart.id)
      end
      @user = current_user

      session.delete(:order_id)

      render 'thankyou'
    end
  end

end

 #encoding: utf-8
class CheckoutController < ApplicationController
  layout "simple"

  def index
		@cart = Cart.find(session[:cart_id])

    @personal_discount = (current_user.personal_discount_available > current_cart.total ? current_cart.total : current_user.personal_discount_available)

    if current_user
      #redirect_to billing_shipping
      # @user = current_user
      # @shipping_address = current_user.addresses.limit(1).where(:billing => 0).first
      # @billing_address = current_user.addresses.limit(1).where(:billing => 1).first

      # if session[:personal_discount] == @user.id
      #   @personal_discount = (@user.personal_discount_available > current_cart.total ? current_cart.total : @user.personal_discount_available)
      # end
      redirect_to :action => "billing_shipping"
    else
      render 'register-login'
    end

  end

  def billing_shipping
    @personal_discount = 0
    @other_discount = 0

    @other_discount = session[:coupon_val] unless session[:coupon_code].nil?

    unless current_user.blank?
      @user = current_user
      @shipping_address = current_user.addresses.where(:billing => 0).first
      @billing_address = current_user.addresses.where(:billing => 1).first
      if session[:personal_discount] == current_user.id
        @personal_discount = (current_user.personal_discount_available > current_cart.total ? current_cart.total : current_user.personal_discount_available)
      end
    end

    render 'billing-shipping'
  end

  def payment

    data = params[:payment]

    if current_user.blank?
      @user = User.create(:email => data[:email], :password => data[:email])
      @user.save!
      @user.title_name = data[:title_name]
      @user.first_name = data[:first_name]
      @user.last_name = data[:last_name]
      @user.phone = data[:phone]
      @user.admin = false
      @user.save!
      session[:checkout_user] = @user.id
    else
      @user = current_user
      @user.title_name = data[:title_name]
      @user.first_name = data[:first_name]
      @user.last_name = data[:last_name]
      @user.phone = data[:phone]
      # @user.admin = false
      @user.save!
    end

    shipping_address = @user.addresses.where(:billing => 0).first
    shipping_address = Address.new(:user_id => @user.id, :billing => 0) if shipping_address.nil?

    shipping_address.city = data[:shipping_city]
    shipping_address.name = data[:shipping_name]
    shipping_address.zip = data[:shipping_zip]
    shipping_address.additional = data[:shipping_additional]
    shipping_address.save!

    shipping = shipping_address.id

    billing_address = current_user.addresses.where(:billing => 1).first

    if data[:same] == 1 && !shipping_address.nil?
      billing = shipping
    else
      billing_address = Address.new(:user_id => @user.id, :billing => 1) if billing_address.nil?

      billing_address.city = data[:billing_city]
      billing_address.name = data[:billing_name]
      billing_address.zip = data[:billing_zip]
      billing_address.additional = data[:billing_additional]
      billing_address.save!

      billing = billing_address.id
    end

    @order = Order.new(:shipping_address_id => shipping, :invoice_address_id => billing, :user_id => @user.id, :status => "Feldolgozás alatt", :estimated_date => ((Time.now + 7.days).to_date))

    sum = 0

    current_cart.line_items.each do |li|
      @order.order_items << OrderItem.create(:product_id => li.product_id, :quantity => li.quantity, :price => li.product.full_price)
      sum = sum + li.product.full_price.to_i
    end

    
    sum = sum - session[:coupon_val].to_i unless session[:coupon_code].nil?
    

    @order.price = sum

    @personal_discount = 0

    if current_user
      if session[:personal_discount] == current_user.id
        @personal_discount = (current_user.personal_discount_available > current_cart.total ? current_cart.total : current_user.personal_discount_available)
      end
    end

    session.delete(:personal_discount)
    @order.discount_used = @personal_discount

    # Payment types:
    # 1 - kártya
    # 2 - paypal
    # 3 - transfer

    @order.payment_type = data[:payment_type]
    if @order.save
      LineItem.destroy_all(:cart_id => current_cart.id)
      UserMailer.order_email(@order).deliver

      unless session[:wishlist_items].blank?
        session[:wishlist_items].each do |item|
          unless @order.order_items.where(:product_id => item[:product_id]).blank?
            w = WishlistItem.find(item[:wishlist_item_id])
            w.sold = 1
            w.save!
          end
        end
        session[:wishlist_items] = []
      end

      unless session[:coupon_code].nil?
        c = Coupon.where(:code => session[:coupon_code]).first
        c.used = 1
        c.order_id = @order.id
        c.save
        session[:coupon_code] = nil
        session[:coupon_val] = nil
      end

      render 'thankyou'
    else
      redirect_to 'billing-shipping'
    end

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
        UserMailer.order_email(@order).deliver
      end

      @personal_discount = @order.discount_used

      if current_user
        @user = current_user
      else
        @user = User.find(session[:checkout_user])
      end

      session.delete(:order_id)

      unless session[:coupon_code].nil?
        c = Coupon.where(:code => session[:coupon_code]).first
        c.used = 1
        c.order_id = @order.id
        c.save
        session[:coupon_code] = nil
      end

      render 'thankyou'
    end
  end

  def lazy_registration
    respond_to do |format|
      if session[:checkout_user].blank?
        format.json { render :json => {:status => "false"} }
      else
        session[:checkout_user] = nil
        format.json { render :json => {:status => "true"} }
      end
    end
  end

end

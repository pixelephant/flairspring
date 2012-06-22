class CheckoutController < ApplicationController
  layout "simple"

  def index
		@cart = Cart.find(session[:cart_id])

    if current_user
      #redirect_to billing_shipping
      @user = current_user
      @shipping_address = current_user.addresses.limit(1).where(:billing => nil).first
      @billing_address = current_user.addresses.limit(1).where(:billing => 1).first
      render 'billing-shipping'
    else
      render 'register-login'
    end

  end

  def billing_shipping
    if current_user
      @user = current_user
      @shipping_address = current_user.addresses.limit(1).where(:billing => nil).first
      @billing_address = current_user.addresses.limit(1).where(:billing => 1).first
    else
      @user = User.new
    end

    render 'billing-shipping'
  end

  def payment
    render 'payment'
  end

  def thankyou
    if current_user
      #@user = current_user
      @user = User.first
      @order = @user.orders.last
      @arrival = "2012-07-01"
      @items = @order.order_items
      @cart = 123
    else
      @user = User.new
      @user = User.first
      @order = @user.orders.last
      @arrival = "2012-07-01"
      @items = @order.order_items
      @cart = 123
    end

    render 'thankyou'
  end

end

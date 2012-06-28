class CartController < ApplicationController
  layout "simple"

  def index
		@cart = Cart.find(session[:cart_id])
    if @cart.line_items.any?
      @r_products = Array.new

      @cart.line_items.each do |li|
        li.product.product_relates.each do |rel|
          @r_products << rel
        end
      end
      render "index"
    else
      render "empty"
    end
	rescue ActiveRecord::RecordNotFound
    @cart = Cart.new
		render "empty"
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @cart }
    end
  end

	def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, :notice => 'Cart was successfully created.' }
        format.json { render :json => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.json { render :json => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  def remove_item
    respond_to do |format|
      if LineItem.delete_all(["cart_id = ? AND product_id = ?", current_cart, params[:id]])
        format.json { render :json => "true" }
      else
        format.json { render :json => "false" }
      end
    end
  end

  def personal
    respond_to do |format|
      if params[:action] == 'personal' && current_user && (session[:personal_discount] != current_user.id)
        session[:personal_discount] = current_user.id
        format.json { render :json => "true" }
      else
        session[:personal_discount] = nil
        format.json { render :json => "false" }
      end
    end
  end

  def coupon
    respond_to do |format|
      if params[:action] == 'coupon' && Coupon.where("used = 0 AND code = '#{params[:code]}' AND valid > NOW()").any? && (session[:coupon_code] != params[:code])
        session[:coupon_code] = params[:code]
        format.json { render :json => "true" }
      else
        session[:coupon_code] = nil
        format.json { render :json => "false" }
      end
    end
  end

end

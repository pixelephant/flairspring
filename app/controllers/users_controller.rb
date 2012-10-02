class UsersController < ApplicationController

  def register
    render "register"
  end

  def account
    if current_user
      @orders = current_user.orders
      @wishlist_items = []
      @wishlist_items = current_user.wishlist.wishlist_items if current_user.wishlist
      @wishlist = current_user.wishlist
      @shipping_address = current_user.addresses.find_by_billing(false)
      @shipping_address = current_user.addresses.first if @shipping_address.nil?

      @billing_address = current_user.addresses.find_by_billing(true)
      @billing_address = current_user.addresses.first if @billing_address.nil?

      unless current_user.addresses.where(:billing => true).first.blank?
        @accounting_name = current_user.addresses.where(:billing => true).first.name
      else
        @accounting_name = current_user.title_name.to_s + " " + current_user.first_name.to_s + " " + current_user.last_name.to_s
      end

      render "account"
    else
      render "new"
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(current_user)

    if @user
      @user.title_name = params[:user]['title_name']
      @user.first_name = params[:user]['first_name']
      @user.last_name = params[:user]['last_name']
      @user.phone = params[:user]['phone']

      billing_address = @user.addresses.where(:billing => true).first
      address = params[:user]['addresses_attributes']['3']
      if billing_address.blank?
        billing_address = Address.create(:name => address['name'], :zip => address['zip'], :city => address['city'], :additional => address['additional'], :billing => true)
        @user.addresses << billing_address
      else
        billing_address.name = address['name']
        billing_address.zip = address['zip']
        billing_address.city = address['city']
        billing_address.additional = address['additional']
        billing_address.save!
      end

      shipping_address = @user.addresses.where(:billing => false).first
      address = params[:user]['addresses_attributes']['0']
      if shipping_address.blank?
        shipping_address = Address.create(:zip => address['zip'], :city => address['city'], :additional => address['additional'], :billing => false)
        @user.addresses << shipping_address
      else
        shipping_address.zip = address['zip']
        shipping_address.city = address['city']
        shipping_address.additional = address['additional']
        shipping_address.save!
      end

      @user.save
    end

    redirect_to '/edit'
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end

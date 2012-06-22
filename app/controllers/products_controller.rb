class ProductsController < ApplicationController
  include ActionView::Helpers::TextHelper
  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show

    @product = Product.find(params[:id])
		@category = @product.category

    @size_weight = @product.properties.joins(:property_category).where(:property_categories => {:id => [74,75,76,77]})
    @properties = @product.properties.joins(:property_category).where("property_categories.id NOT IN (74,75,76,77)")

    @title = @product.name.titleize + " - " + @category.name
    @description = truncate(@product.long_description, :length => 156).capitalize
    @keywords = @product.name + "," + @category.name

		#session[:last_viewed_products] = []
		(session[:last_viewed_products] ||= []).delete(params[:id])
		session[:last_viewed_products] << params[:id] if !session[:last_viewed_products].index(params[:id])
    session[:last_viewed_products] = session[:last_viewed_products][(session[:last_viewed_products].length-6),6] if session[:last_viewed_products].length > 6
		@designer = @product.designer
		@brand = @product.brand
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @product }
    end
  end

	# POST /products/quicklook/1
	# POST /products/quicklook/1.json
	def quicklook
    @product = Product.find(params[:id])
		@category = @product.category

    @size_weight = @product.properties.joins(:property_category).where(:property_categories => {:id => [74,75,76,77]})
		#session[:last_viewed_products] = []
		(session[:last_viewed_products] ||= []).delete(params[:id])
		session[:last_viewed_products] << params[:id] if !session[:last_viewed_products].index(params[:id])
		@designer = @product.designer
		@brand = @product.brand
    respond_to do |format|
      format.html { render :partial => 'modal_product' }
      format.json { render :json => @product }
    end
	end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, :notice => 'Product was successfully created.' }
        format.json { render :json => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, :notice => 'Product was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :ok }
    end
  end
end

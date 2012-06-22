class ProductsStoresController < ApplicationController
  # GET /products_stores
  # GET /products_stores.json
  def index
    @products_stores = ProductsStore.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products_stores }
    end
  end

  # GET /products_stores/1
  # GET /products_stores/1.json
  def show
    @products_store = ProductsStore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @products_store }
    end
  end

  # GET /products_stores/new
  # GET /products_stores/new.json
  def new
    @products_store = ProductsStore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @products_store }
    end
  end

  # GET /products_stores/1/edit
  def edit
    @products_store = ProductsStore.find(params[:id])
  end

  # POST /products_stores
  # POST /products_stores.json
  def create
    @products_store = ProductsStore.new(params[:products_store])

    respond_to do |format|
      if @products_store.save
        format.html { redirect_to @products_store, :notice => 'Products store was successfully created.' }
        format.json { render :json => @products_store, :status => :created, :location => @products_store }
      else
        format.html { render :action => "new" }
        format.json { render :json => @products_store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products_stores/1
  # PUT /products_stores/1.json
  def update
    @products_store = ProductsStore.find(params[:id])

    respond_to do |format|
      if @products_store.update_attributes(params[:products_store])
        format.html { redirect_to @products_store, :notice => 'Products store was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @products_store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products_stores/1
  # DELETE /products_stores/1.json
  def destroy
    @products_store = ProductsStore.find(params[:id])
    @products_store.destroy

    respond_to do |format|
      format.html { redirect_to products_stores_url }
      format.json { head :ok }
    end
  end
end

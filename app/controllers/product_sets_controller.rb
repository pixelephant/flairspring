class ProductSetsController < ApplicationController
  # GET /product_sets
  # GET /product_sets.json
  def index
    @product_sets = ProductSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @product_sets }
    end
  end

  # GET /product_sets/1
  # GET /product_sets/1.json
  def show
    @product_set = ProductSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @product_set }
    end
  end

  # GET /product_sets/new
  # GET /product_sets/new.json
  def new
    @product_set = ProductSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product_set }
    end
  end

  # GET /product_sets/1/edit
  def edit
    @product_set = ProductSet.find(params[:id])
  end

  # POST /product_sets
  # POST /product_sets.json
  def create
    @product_set = ProductSet.new(params[:product_set])

    respond_to do |format|
      if @product_set.save
        format.html { redirect_to @product_set, :notice => 'Product set was successfully created.' }
        format.json { render :json => @product_set, :status => :created, :location => @product_set }
      else
        format.html { render :action => "new" }
        format.json { render :json => @product_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_sets/1
  # PUT /product_sets/1.json
  def update
    @product_set = ProductSet.find(params[:id])

    respond_to do |format|
      if @product_set.update_attributes(params[:product_set])
        format.html { redirect_to @product_set, :notice => 'Product set was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_sets/1
  # DELETE /product_sets/1.json
  def destroy
    @product_set = ProductSet.find(params[:id])
    @product_set.destroy

    respond_to do |format|
      format.html { redirect_to product_sets_url }
      format.json { head :ok }
    end
  end
end

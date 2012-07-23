class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @category = Category.first
    @custom_categories = @category.custom_categories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show


    if params[:sort] == 'by_name'
      sort = 'name'
    elsif params[:sort] == 'by_lowest_price'
      sort = 'price ASC'
    elsif params[:sort] == 'by_highest_price'
      sort = 'price DESC'
    else
      sort = 'updated_at'
    end

    @category = Category.find(params[:id])
		@products = @category.products.order(sort)

    @title = " - " + @category.name.capitalize

    @description = @category.name.to_s.capitalize

    @keywords = ""
    # @category.custom_categories.each do |cc|
      # @keywords = @keywords + "," + cc.name
    # end
    # @keywords = @keywords + "," + @description

    if params[:page] == 'all'
      session[:view_all] = true
      @kaminari_products = Kaminari.paginate_array(@products).page(params[:page]).per(21)
    else
      session[:view_all] = false
      @products = Kaminari.paginate_array(@products).page(params[:page]).per(21)
      @kaminari_products = @products
    end

    respond_to do |format|
      # format.html # show.html.erb
      format.html
      format.json { render :json => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, :notice => 'Category was successfully created.' }
        format.json { render :json => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, :notice => 'Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :ok }
    end
  end
end

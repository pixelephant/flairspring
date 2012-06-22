class CustomCategoriesController < ApplicationController
  # GET /custom_categories
  # GET /custom_categories.json
  def index
    @custom_categories = CustomCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @custom_categories }
    end
  end

  # GET /custom_categories/1
  # GET /custom_categories/1.json
  def show

    # @custom_category = CustomCategory.find(params[:id])
		# @category = @custom_category.category
    @category = Category.find(params[:id])
    @custom_category = Category.find(params[:id])

    # @title = " - " + @category.name.capitalize + " - " + @custom_category.name.titleize
    @title = @category.name.capitalize
    property_categories = PropertyCategory.where("id NOT IN (79,78,73)")

    @property_categories = []

    property_categories.each do |property_category|
      if property_category.properties.any?
        p = Hash.new
        p.store(:name, property_category.category_name.to_s)
        p[:id] = property_category.id
        if property_category.properties.first.num.nil? || property_category.properties.last.num.nil?
          p[:numeric] = false
        else
          p[:numeric] = true

          p[:to] = Property.all(:select => "MAX(properties.num) AS num", :joins => :products, :conditions => "products.category_id = #{@category.id} AND properties.property_category_id = #{property_category.id}", :group => "property_category_id").first.num.to_f.ceil
          p[:from] = Property.all(:select => "MIN(properties.num) AS num", :joins => :products, :conditions => "products.category_id = #{@category.id} AND properties.property_category_id = #{property_category.id}", :group => "property_category_id").first.num.to_f.floor
          v = params[property_category.id.to_s].split(";") if params[property_category.id.to_s]
          params[property_category.id.to_s] ? p[:low] = v[0].to_f.floor : p[:low] = p[:from]
          params[property_category.id.to_s] ? p[:high] = v[1].to_f.ceil : p[:high] = p[:to]
          p[:unit] = property_category.category_name.scan(/\(?\w+\)/)[-1].gsub(")","").gsub("(","")
        end
        @property_categories << p
      end
    end

    @description = @custom_category.name.to_s.capitalize

    @keywords = ""

    # if @custom_category.properties.any?
    #   @custom_category.properties.each do |prop|
    #     @keywords = @keywords + "," + prop.property_name
    #   end
    # end

    # @property_categories = PropertyCategory.find(:all, :joins => :property_categories_to_categories, :select => "property_categories.*", :conditions => ["property_categories_to_categories.category_id = #{@category.id}"], :group => "property_categories.id")    
    @designers = Designer.find(:all, :joins => :products, :select => "designers.*", :conditions => ["designers.id = products.designer_id AND products.category_id = #{@category.id}"], :group => "designers.id")

    where = []
    designer = []

    unless params[:designer].blank?
      params[:designer].each do |d|
        designer << d
      end
    end

    where << ("designer_id IN (" + designer.join(",") + ")") unless designer.blank?

    properties = []

    params.each do |key, val|
      unless key.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil
        if val.split(";").count == 2
          a = val.split(";")
          # where << "(SELECT count(products.id) FROM properties INNER JOIN products_properties ON properties.id = products_properties.property_id INNER JOIN products ON products.id = products_properties.product_id WHERE (properties.property_category_id = #{key}) AND (properties.numeric BETWEEN #{a[0]} AND #{a[1]})) > 1"
          Property.where("(properties.num BETWEEN #{a[0]} AND #{a[1]}) AND (properties.property_category_id = #{key})").each do |p|
            properties << p.id
          end
          v = properties.join(",")
          where << "(properties.id IN (#{v}))" unless v.blank?
          properties = []
        else
          v = []
          params[key].each do |p|
            v << p.to_s
          end
          i = v.join(",")
          #where << "((properties.property_category_id = #{key}) AND (properties.id IN (#{i})))"
          properties << i unless i.blank?
        end
      end
    end

    v = properties.join(",")
    where << "(properties.id IN (#{v}))" unless v.blank?

		if params[:sort] == 'by_name'
			sort = 'products.name'
		elsif params[:sort] == 'by_lowest_price'
			sort = 'products.price ASC'
		elsif params[:sort] == 'by_highest_price'
			sort = 'products.price DESC'
		else
			sort = 'products.updated_at'
		end

    condit = where.join(" AND ") unless where.blank?

		if params[:page] == 'all'
			session[:view_all] = true
      #Eredeti custom category
			# @products = @custom_category.products(sort)
			# @kaminari_products = Kaminari.paginate_array(@custom_category.products(sort, params)).page(params[:page]).per(21)
      #Category
      # @products = @category.products.joins(:properties).where(condit)
      # @kaminari_products = Kaminari.paginate_array(@category.products.joins(:properties).where(condit).select("DISTINCT products.*").order(sort)).page(params[:page]).per(21)
      p = @category.products.select("DISTINCT products.id").joins(:properties).where(condit)
      @products = Product.where(:id => p)
      @kaminari_products = Kaminari.paginate_array(@products.order(sort)).page(params[:page]).per(21)
		else
			session[:view_all] = false
      #Custom Category
		# @products = Kaminari.paginate_array(@custom_category.products(sort, params)).page(params[:page]).per(21)
    #Category
      #@products = Kaminari.paginate_array(@category.products.joins(:properties).where(condit).select("DISTINCT products.*").order(sort)).page(params[:page]).per(21)
      p = @category.products.select("DISTINCT products.id").joins(:properties).where(condit)
      @products = Product.where(:id => p).order(sort)
			@kaminari_products = Kaminari.paginate_array(@products).page(params[:page]).per(21)
		end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @custom_category }
    end
  end

  # GET /custom_categories/new
  # GET /custom_categories/new.json
  def new
    @custom_category = CustomCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @custom_category }
    end
  end

  # GET /custom_categories/1/edit
  def edit
    @custom_category = CustomCategory.find(params[:id])
  end

  # POST /custom_categories
  # POST /custom_categories.json
  def create
    @custom_category = CustomCategory.new(params[:custom_category])

    respond_to do |format|
      if @custom_category.save
        format.html { redirect_to @custom_category, :notice => 'Custom category was successfully created.' }
        format.json { render :json => @custom_category, :status => :created, :location => @custom_category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @custom_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /custom_categories/1
  # PUT /custom_categories/1.json
  def update
    @custom_category = CustomCategory.find(params[:id])

    respond_to do |format|
      if @custom_category.update_attributes(params[:custom_category])
        format.html { redirect_to @custom_category, :notice => 'Custom category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @custom_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_categories/1
  # DELETE /custom_categories/1.json
  def destroy
    @custom_category = CustomCategory.find(params[:id])
    @custom_category.destroy

    respond_to do |format|
      format.html { redirect_to custom_categories_url }
      format.json { head :ok }
    end
  end
end

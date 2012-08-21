class CustomCategoriesController < ApplicationController
  # GET /custom_categories
  # GET /custom_categories.json

  # caches_action :show, :cache_path => Proc.new { |c| c.params }

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

    unless params[:id] == 'osszes' || !Brand.find_by_name(params[:id]).blank?
      @category = Category.find(params[:category_id])
      @custom_category = CustomCategory.find(params[:id])
    else
      @category = Category.find(params[:category_id])
      @custom_category = Category.find(params[:category_id])
    end

    # @title = " - " + @category.name.capitalize + " - " + @custom_category.name.titleize
    @title = @category.name.capitalize
    
    prod_ids = []

    unless @custom_category.products.blank?
      @custom_category.products.each do |pr|
        prod_ids << pr.id
      end
      @custom_category_empty = false
    else
      @custom_category_empty = true
    end

    prod_sql = ""
    unless prod_ids.blank?
      prod_sql = " AND products.id IN (#{prod_ids.join(',')})"
    end

    # property_categories = PropertyCategory.where("id NOT IN (79,78,73) AND id IN (#{@category.dynamic_property_categories.join(",")})")
    property_categories = @category.property_categories.where(:visible => 1)

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

          min_max = Property.all(:select => "MAX(properties.num) AS max_num, MIN(properties.num) AS min_num", :joins => :products, :conditions => "products.category_id = #{@category.id} AND properties.property_category_id = #{property_category.id}#{prod_sql}", :group => "property_category_id")

          # p[:to] = Property.all(:select => "MAX(properties.num) AS num", :joins => :products, :conditions => "products.category_id = #{@category.id} AND properties.property_category_id = #{property_category.id}#{prod_sql}", :group => "property_category_id").first.num.to_f.ceil
          # p[:from] = Property.all(:select => "MIN(properties.num) AS num", :joins => :products, :conditions => "products.category_id = #{@category.id} AND properties.property_category_id = #{property_category.id}#{prod_sql}", :group => "property_category_id").first.num.to_f.floor

          p[:to] = min_max.any? ? min_max.first.max_num.to_f.ceil : 0
          p[:from] = min_max.any? ? min_max.first.min_num.to_f.floor : 0

          v = params[property_category.id.to_s].split(";") if params[property_category.id.to_s]
          p[:low] = params[property_category.id.to_s] ? v[0].to_f.floor : p[:from]
          p[:high] = params[property_category.id.to_s] ? v[1].to_f.ceil : p[:to]
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
    @brands = Brand.find(:all, :joins => :products, :select => "brands.*", :conditions => ["brands.id = products.brand_id AND products.category_id = #{@category.id}"], :group => "brands.id")

    where = []
    designer = []
    

    unless params[:designer].blank?
      params[:designer].each do |d|
        unless d.blank?
          designer << d
        end
      end
    end

    where << ("designer_id IN (" + designer.join(",") + ")") unless designer.blank?

    brand = []
    unless params[:brand].blank?
      params[:brand].each do |b|
        unless Brand.find_by_name(b).blank?
          brand << Brand.find_by_name(b).id
        end
      end
    end

    where << ("brand_id IN (" + brand.join(",") + ")") unless brand.blank?


    properties = []

    # property_count = 0
    property_category_count = 0

    params.each do |key, val|
      unless key.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil
        if val.split(";").count == 2
          a = val.split(";")
          
          property = Property.where("(properties.num BETWEEN #{a[0]} AND #{a[1]}) AND (properties.property_category_id = #{key})")
          property.each do |p|
            properties << p.id
          end
          # property_count = property_count.to_i + 1
          property_category_count = property_category_count + 1
        else
          v = []
          params[key].each do |p|
            v << p.to_s
            properties << p
          end
          # property_count = property_count.to_i + v.count.to_i
          property_category_count = property_category_count + 1
        end
      end
    end

    #CustomCategoryProp
    @fix_properties = Hash.new
    @custom_category.properties.each do |p|
      @fix_properties[p.property_category_id] = [] if @fix_properties[p.property_category_id].nil?
      @fix_properties[p.property_category_id] << p.id
      properties << p.id
      # property_count = property_count + 1
    end
    property_category_count = property_category_count + @custom_category.properties.select("Distinct property_category_id").count.to_i

    v = properties.join(",")
    where << "(properties.id IN (#{v}))" unless v.blank?

		if params[:sort] == 'by_name'
			sort = 'products.name'
		elsif params[:sort] == 'by_lowest_price'
			sort = 'products.price ASC'
		elsif params[:sort] == 'by_highest_price'
			sort = 'products.price DESC'
		else
			sort = 'products.created_at'
		end

    if params[:recommend] == "new"
      where << "(products.created_at > (CURDATE() - INTERVAL #{NEW_PRODUCT_DAYS} DAY))"
      # property_count = property_count + 1
    end

    discount_sql_table = ""
    discount_sql_column = ""
    if params[:recommend] == "sale"
      where << "(discounts_to_products.discount_id IS NOT NULL OR categories.discount_id IS NOT NULL)"
      # property_count = property_count + 1
      discount_sql_table = " LEFT JOIN discounts_to_products ON products.id = discounts_to_products.product_id INNER JOIN categories ON products.category_id = categories.id"
      discount_sql_column = ",discounts_to_products.discount_id"
    end

    # condit = " AND " + where.join(" AND ") unless where.blank?
    # condit = " AND " + where[0] if where.count == 1

    unless where.blank?
      if where.count == 1
        # condit = " AND " + where[0]
      else
        condit = " AND " + where.join(" AND ")
      end
    end

    # condit = where.join(" AND ") unless where.blank?

    logger.debug "property_category_count: #{condit}"

    unless @custom_category.products.blank?
      #logger.debug "property_category_count: #{property_category_count}"
      if property_category_count > 0
        p = Product.find_by_sql("SELECT prop.id FROM (SELECT DISTINCT products.id, COUNT(properties.id) AS prop_count#{discount_sql_column} FROM `products` INNER JOIN `products_properties` ON `products_properties`.`product_id` = `products`.`id` INNER JOIN `properties` ON `properties`.`id` = `products_properties`.`property_id`#{discount_sql_table} WHERE `products`.`category_id` = #{@category.id}#{condit} GROUP BY products.id) AS prop WHERE prop.prop_count >= #{property_category_count}")
      else
        p = @custom_category.products.select("id").where(condit)
      end

  		if params[:page] == 'all'
  			session[:view_all] = true

        @products = Product.where(:id => p)
        @kaminari_products = Kaminari.paginate_array(@products.order(sort)).page(params[:page]).per(21)
  		else
  			session[:view_all] = false

        @products = Product.where(:id => p).order(sort).page(params[:page]).per(21)
  			# @kaminari_products = Kaminari.paginate_array(@products).page(params[:page]).per(21)
        @kaminari_products = @products
  		end
    else
      @products = []
      @kaminari_products = []
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

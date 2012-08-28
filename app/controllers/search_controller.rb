class SearchController < ApplicationController
	# GET /search
  # GET /search.json
  def index
   #  @search = Product.search do
  	#   fulltext params[:search]
	  # end

	  if params[:search]

	  	where = ""

	  	unless params[:designer].blank?
		  	designer = []
	      params[:designer].each do |d|
		      unless d.blank?
		        designer << d
		      end
		    end
	    end

	    where = (" AND designer_id IN (" + designer.join(",") + ")") unless designer.blank?

		 	@products = Product.where("(name LIKE ('%#{params[:search]}%') OR long_description LIKE ('%#{params[:search]}%')) AND visible = 1#{where}")

		 	product_id = []

		 	@products.each do |prod|
		 		product_id << prod.id
		 	end
		 	
		 	product_id = product_id.join(",")

		  @fix_properties = Hash.new

		  @designers = Designer.where("designers.id IN (SELECT designer_id FROM products WHERE id IN (#{product_id}))")
		  @property_categories = []
		 else
		 	@products = []
		 end

		if params[:page] == 'all'
			session[:view_all] = true
			#@products = @search.results
			@kaminari_products = Kaminari.paginate_array(@products).page(params[:page]).per(21)
		else
			session[:view_all] = false
			@products = Kaminari.paginate_array(@products).page(params[:page]).per(21)
			@kaminari_products = @products
		end

  	#@products = @search.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
    end
  end
end

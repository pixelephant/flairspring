class SearchController < ApplicationController
	# GET /search
  # GET /search.json
  def index
    @search = Product.search do
  	  fulltext params[:search]
	  end

	  @designers = Designer.all
	  @property_categories = PropertyCategory.limit(2)

		if params[:page] == 'all'
			session[:view_all] = true
			@products = @search.results
			@kaminari_products = Kaminari.paginate_array(@search.results).page(params[:page]).per(21)
		else
			session[:view_all] = false
			@products = Kaminari.paginate_array(@search.results).page(params[:page]).per(21)
			@kaminari_products = @products
		end

  	#@products = @search.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
    end
  end
end

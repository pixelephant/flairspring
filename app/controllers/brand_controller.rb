class BrandController < ApplicationController
  def index
    render "index"
  end

  def lazboy
  	render "lazboy"
  end

  def uttermost
  	@products = Product.where(:sku => ["06657","13364 p","14028 b","19431","19506","19550","24203","26460","26685","34230","60104"])
  	render "uttermost"
  end

end
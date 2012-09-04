class RemovedPropertyToProductVariation < ActiveRecord::Base

	belongs_to :product_variation
	belongs_to :property
	
end

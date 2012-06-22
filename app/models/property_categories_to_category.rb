class PropertyCategoriesToCategory < ActiveRecord::Base
	belongs_to :property_category
	belongs_to :category
end

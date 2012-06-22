class PropertiesToProduct < ActiveRecord::Base
	belongs_to :property
	belongs_to :product
end

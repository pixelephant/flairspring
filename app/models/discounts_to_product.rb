class DiscountsToProduct < ActiveRecord::Base
	belongs_to :discount
	belongs_to :product

end

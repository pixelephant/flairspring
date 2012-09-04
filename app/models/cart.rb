class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy

	def add_product(product_id,quantity,product_variation_id=nil,product_set_id=nil)
		current_item = line_items.find_by_product_id(product_id)
		if current_item && current_item.product_set_id == product_set_id && current_item.product_variation_id == product_variation_id
			current_item.quantity += quantity.to_i
		else
			current_item = line_items.build(:product_id => product_id, :quantity => quantity, :product_variation_id => product_variation_id, :product_set_id => product_set_id)
		end
		current_item
	end

	def total
		total = 0
		product_sets = []
		product_variations = []
		self.line_items.find_each do |item|
			if item.product_set_id.nil? && item.product_variation_id.nil?
				total += item.quantity * item.product.full_price
			else
				unless item.product_set_id.nil? || product_sets.include?(item.product_set_id)
					total += item.quantity * ProductSet.find(item.product_set_id).price
					product_sets << item.product_set_id
				end
				unless item.product_variation_id.nil? || product_variations.include?(item.product_variation_id)
					total += item.quantity * ProductVariation.find(item.product_variation_id).price
					product_variations << item.product_variation_id
				end
			end
		end
		total
	end
end

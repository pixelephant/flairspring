class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy

	def add_product(product_id,quantity)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += quantity.to_i
		else
			current_item = line_items.build(:product_id => product_id, :quantity => quantity)
		end
		current_item
	end

	def total
		total = 0
		self.line_items.find_each do |item|
			total += item.quantity * item.product.price
		end
		total
	end
end

class ProductSet < ActiveRecord::Base
	has_and_belongs_to_many :products
	has_and_belongs_to_many :properties

	validates :price, :presence => true

	def brands
		brands = Array.new
		self.products.each do |product|
			brands << product.brand if !brands.include?(product.brand)
		end
		brands
	end
end

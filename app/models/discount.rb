#encoding: utf-8
class Discount < ActiveRecord::Base
	has_many :discounts_to_products
	has_many :products, :through => :discounts_to_products

	has_many :categories
	has_many :custom_categories

	validates :discount_type, :value, :presence => true

	def discount_type_enum
      [ [ 'Összeg', '1' ], [ 'Százalék', '2' ] ]
  end
end
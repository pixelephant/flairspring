class Property < ActiveRecord::Base

	translates :property_name

	before_save :add_numeric

	has_many :property_translations, :dependent => :destroy
	accepts_nested_attributes_for :property_translations

	#has_many :properties_to_products
	#has_many :products, :through => :properties_to_products
	has_and_belongs_to_many :products

	has_many :properties_to_line_items
	has_many :line_items, :through => :properties_to_line_items

	belongs_to :property_category
	has_many :properties_to_category
	has_many :categories, :through => :properties_to_category

	has_many :properties_to_custom_categories
	has_many :custom_categories, :through => :properties_to_custom_categories

	has_and_belongs_to_many :product_sets

	validates :property_name, :presence => true

	private

	def add_numeric
		self.num = self.property_name.gsub(",",".").to_f if helper.is_a_number?(self.property_name.gsub(",","."))
	end

end

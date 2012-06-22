class PropertyCategory < ActiveRecord::Base

	translates :category_name

	has_many :property_category_translations, :dependent => :destroy
	accepts_nested_attributes_for :property_category_translations

	has_many :properties
	has_many :property_categories_to_categories
	has_many :categories, :through => :property_categories_to_categories

	validates :category_name, :presence => true

end

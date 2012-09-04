class ProductVariation < ActiveRecord::Base

	belongs_to :product

	has_many :extra_properties_to_product_variations
	has_many :additional_properties, :through => :extra_properties_to_product_variations, :class_name => "Property", :foreign_key => "property_id", :source => :property

	has_many :removed_property_to_product_variations
	has_many :removed_properties, :through => :removed_property_to_product_variations, :class_name => "Property", :foreign_key => "property_id", :source => :property

end

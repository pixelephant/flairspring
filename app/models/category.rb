class Category < ActiveRecord::Base

	translates :name

	default_scope :order => 'position ASC'

	has_many :category_translations, :dependent => :destroy
	accepts_nested_attributes_for :category_translations

	extend FriendlyId
	friendly_id :name, :use => [:slugged]

	mount_uploader :image_file, ImageUploader

	has_many :products
	has_many :property_categories_to_categories
	has_many :property_categories, :through => :property_categories_to_categories
	has_many :properties_to_category
	has_many :properties, :through => :properties_to_category

	has_many :custom_categories
	has_and_belongs_to_many :custom_category_groups

	belongs_to :discount

	validates :name, :presence => true

	def dynamic_property_categories
		a = []
		self.products.each do |product|
			a = (a|product.property_category_ids)
		end

		return a
	end

end

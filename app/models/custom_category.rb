class CustomCategory < ActiveRecord::Base

  default_scope :order => 'custom_category_group_id DESC'

	extend FriendlyId
	friendly_id :name, :use => :slugged

	translates :name

	has_many :custom_category_translations, :dependent => :destroy
	accepts_nested_attributes_for :custom_category_translations

	has_many :properties_to_custom_categories
	has_many :properties, :through => :properties_to_custom_categories

	# accepts_nested_attributes_for :properties

	belongs_to :category
	belongs_to :discount
	belongs_to :custom_category_group

	validates :name,:category_id , :presence => true

	def products

		category_id = self.category.id
		properties = self.properties
		property_count = properties.count

		return nil if properties.blank?

		prop = []
		properties.each do |p|
			prop << p.id
		end
		v = prop.join(",")
    condit = " AND (properties.id IN (#{v}))"

		p = Product.find_by_sql("SELECT prop.id FROM (SELECT DISTINCT products.id AS id, COUNT(properties.id) AS prop_count FROM `products` INNER JOIN `products_properties` ON `products_properties`.`product_id` = `products`.`id` INNER JOIN `properties` ON `properties`.`id` = `products_properties`.`property_id` WHERE `products`.`category_id` = #{category_id}#{condit} GROUP BY products.id) AS prop WHERE prop.prop_count >= #{property_count}")
		return nil if p.blank?
		ids = []
		p.each do |i|
			ids << i.id
		end
		p = Product.where("products.id IN (#{ids.join(',')})")
		return p
	end

end

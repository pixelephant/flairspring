class Product < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, :use => :slugged

	translates :short_description, :long_description, :advice

	has_many :product_translations, :dependent => :destroy
	accepts_nested_attributes_for :product_translations

	has_many :photos
	belongs_to :category
#	has_many :properties_to_products
#	has_many :properties, :through => :properties_to_products
	has_and_belongs_to_many :properties
	has_and_belongs_to_many :links
	has_and_belongs_to_many :stores

	has_many :wishlist_items
	has_many :advantages, :through => :advantages_to_products
	has_many :advantages_to_products
	belongs_to :designer
	# belongs_to :manufacturer
	belongs_to :brand

	has_many :related_products
	has_many :product_relates, :through => :related_products, :foreign_key => "product_id"
	has_many :inverse_related_products, :class_name => "RelatedProduct", :foreign_key => "related_product_id"
	has_many :inverse_product_relates, :through => :inverse_related_products, :source => :product

	has_many :discounts_to_products
	has_many :discounts, :through => :discounts_to_products

	has_and_belongs_to_many :product_sets

	has_many :order_items

	has_many :line_items

	validates :name, :sku, :price, :category, :presence => true

	validates :sku, :name, :uniqueness => true

	attr_protected

	# searchable do
 #    text :name, :short_description, :long_description
 # 			# text :product_translations do
	# 	  #   product_translations.map {|product_translation|  product_translation.long_description}
	#   	# end
 #  end


	def default_photo
		default = self.photos.where("photos.default = 1").exists? ? self.photos.where("photos.default = 1").first : self.photos.first
    return default
  end

	def self.products_on_sale
		self.find(:all, :joins => :discounts, :select => "products.*", :conditions => ["discounts.id IS NOT NULL"], :group => "products.id")
	end

	def weight
		a = PropertyCategory.where(:category_name => 'Weight').first.properties
		return nil if a.blank?
		self.properties.where(:id => a).first.property_name
	end

	def dimensions
		a = PropertyCategory.where(:category_name => 'Overall Width').first.properties
		w = self.properties.where(:id => a).first.property_name if self.properties.where(:id => a).any?

		a = PropertyCategory.where(:category_name => 'Overall Height').first.properties
		h = self.properties.where(:id => a).first.property_name if self.properties.where(:id => a).any?

		a = PropertyCategory.where(:category_name => 'Overall Depth').first.properties
		d = self.properties.where(:id => a).first.property_name if self.properties.where(:id => a).any?

		if w.nil? || h.nil? || d.nil?
			return nil
		end

		return w.to_s + " x " + h.to_s + " x " + d.to_s
	end

	def optional_properties
		self.properties.find(:all, :group => "property_category_id", :having => "SUM(properties.property_category_id) > properties.property_category_id")
	end

	def given_properties
		self.properties.find(:all, :group => "property_category_id", :having => "SUM(properties.property_category_id) = properties.property_category_id")
	end

	def full_price
		product_id = self.id
		p = Product.find(product_id)

		if p.price.blank?
			return ''
		end
		price = p.price

		#Product discount factor
		p.discounts.each do |d|
			if d.discount_type == 1
				price = price - d.value
			end

			if d.discount_type == 2
				price = price - (price * (d.value.to_f / 100))
			end
		end

		return price.round if price < p.price

		#Custom category discount factor

#		if p.custom_category.any?
#			p.custom_category.discount.each do |d|
#				if d.discount_type == 1
#					price = price - d.value
#				end
#
#				if d.discount_type == 2
#					price = price - (price * (d.value.to_f / 100))
#				end
#			end
#		end

#		return price.round if price < p.price

		#Category discount factor
		if !p.category.discount.nil?
			d = p.category.discount
			
			if d.discount_type == 1
				price = price - d.value
			end

			if d.discount_type == 2
				price = price - (price * (d.value.to_f / 100))
			end

			return price.round if price < p.price
		end
		return price
	
	end

	def on_sale?
		self.full_price < self.price ? true : false
	end

	def new?
		((Time.now - self.created_at).to_i / (3600 * 24) < NEW_PRODUCT_DAYS) ? true : false
	end

	def property_category_ids
		a = []
		self.properties.group(:property_category_id).each do |prop|
			a << prop.property_category_id
		end
		return a
	end

end
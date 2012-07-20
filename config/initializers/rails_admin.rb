#encoding: utf-8
RailsAdmin.config do |config|

	config.main_app_name = "Flairspring"

	require 'i18n'
  I18n.default_locale = :en

	config.authorize_with :cancan

	#Custom actions
	config.actions do
		# member :import do
		# 	i18n_key :import
		# end
		config.actions do
		  # root actions
		  dashboard                     # mandatory
		  # collection actions
		  index                         # mandatory
		  new
		  export
		  history_index
		  bulk_delete
		  # member actions
		  show
		  edit
		  delete
		  history_show
		  show_in_app
		end
	end


	#Add all excluded models here:
	config.excluded_models = [PropertiesToProduct, Wishlist, WishlistItem, PropertyCategoriesToCategory,AdvantagesToProduct,DiscountsToProduct,PropertiesToCategory,RelatedProduct,
PropertiesToCustomCategory,PropertiesToLineItem,Cart, LineItem, MassUpload]

	#Visibility START
	config.model AdvantageTranslation do
		visible false
	end

	config.model CategoryTranslation do
		visible false
	end

	config.model ContentTranslation do
		visible false
	end

	config.model CustomCategoryGroupTranslation do
		visible false
	end

	config.model CustomCategoryTranslation do
		visible false
	end

	config.model DesignerTranslation do
		visible false
	end

	config.model ManufacturerTranslation do
		visible false
	end

	config.model ProductTranslation do
		visible false
	end

	config.model PropertyCategoryTranslation do
		visible false
	end

	config.model PropertyTranslation do
		visible false
	end

	config.model SubcontentTranslation do
		visible false
	end

	config.model LinksProduct do
		visible false
	end

	config.model ProductsStore do
		visible false
	end

	#Visibility END

	#Address
	config.model Address do
		#Property name
		object_label_method do
			:address_label_method
		end
	end

	#Category
	config.model Category do
		edit do
			exclude_fields :custom_categories, :slug, :properties
			field :name
			field :position
		end
	end

	#Content
	config.model Content do
		edit do
			exclude_fields :slug
		end
	end

	#Coupon
	config.model Coupon do
		object_label_method do
			:coupon_label_method
		end
		list do
			field :id
			field :offer_type do
				pretty_value do
					value == 1 ? 'Összeg' : 'Termék'
				end
			end
			include_all_fields
		end
		show do
			field :id
			field :offer_type do
				pretty_value do
					value == 1 ? 'Összeg' : 'Termék'
				end
			end
			include_all_fields
		end
		#Discount edit form
		edit do
			field :offer_type do
				partial "discount_dropdown"
			end
			include_all_fields
		end
	end

	#Property
	config.model Property do
		#Property name
		object_label_method do
			:property_label_method
		end
		edit do
			exclude_fields :categories, :custom_categories, :num
		end
	end

	#PropertyCategory
	config.model PropertyCategory do
		#PropertyCategory name
		object_label_method do
			:property_category_label_method
		end
	end

	#Product
	config.model Product do
		#Product edit form

		edit do
			field :name do
				
			end

			field :product_relates do
				# associated_collection_scope do
				# 	product = bindings[:object]
				# 	Proc.new { |scope|
				# 		scope = scope.where("products.id != ?", product.id) if product.id.present?
				# 		scope
				# 	}
				# end
			end
			include_all_fields
			exclude_fields :properties_to_products, :advantages_to_products, :discounts_to_products, :inverse_product_relates, :order_items, :line_items, :slug, :click
		end
	end

	#CustomCategory


	config.model CustomCategory do
		#Product edit form
		edit do
			exclude_fields :properties_to_products, :advantages_to_products, :discounts_to_products, :inverse_product_relates, :slug
			include_all_fields
		end
	end

	#Discount
	config.model Discount do
		#Discount list view
		list do
			field :id
			field :discount_type do
				pretty_value do
					value == 1 ? 'Value' : 'Percent'
				end
			end
			include_all_fields
			exclude_fields :products
		end
		#Discount list view
		show do
			field :id
			field :discount_type do
				pretty_value do
					value == 1 ? 'Value' : 'Percent'
				end
			end
			include_all_fields
			exclude_fields :products
		end
		#Discount edit form
		edit do
			field :discount_type do
				partial "discount_dropdown"
			end
			include_all_fields
			exclude_fields :products
		end
		object_label_method do
			:discount_label_method
		end
	end

	#Photos name
	config.model Photo do
		object_label_method do
			:photo_label_method
		end
	end

	#Designer Photos
	config.model DesignerPhoto do
		object_label_method do
			:photo_label_method
		end
	end

	#Manufacturer Photos
	config.model ManufacturerPhoto do
		object_label_method do
			:photo_label_method
		end
	end

	#RelatedProducts name
	config.model RelatedProduct do
		object_label_method do
			:related_product_label_method
		end
	end

	#Advantage name
	config.model Advantage do
		object_label_method do
			:advantage_label_method
		end
	end

	#Order
	config.model Order do
		edit do
			exclude_fields :payment_type, :discount_used, :basket_serialization
			include_all_fields
		end
		object_label_method do
			:order_label_method
		end
	end

	#OrderItem
	config.model OrderItem do
		object_label_method do
			:order_item_label_method
		end
	end

	#Links
	config.model Link do
		object_label_method do
			:link_label_method
		end
	end

	#Stores
	config.model Store do
		object_label_method do
			:store_label_method
		end
	end

	config.model User do
		object_label_method do
			:user_label_method
		end
	end

	#Custom label methods
	# def property_label_method
	# 	if self.property_category.nil?
	# 		self.property_name
	# 	else
	# 		self.property_category.category_name + ": " + self.property_name
	# 	end
	# end

	def property_label_method
		self.property_category ? self.property_category.category_name + ": " + self.property_name : self.property_name
	end

	def property_category_label_method
		self.category_name
	end

	def photo_label_method
		self.alt
	end

	def related_product_label_method
		self.product_relates.name
	end

	def advantage_label_method
		self.name
	end

	def discount_label_method
		type = self.discount_type == 2 ? ' %' : ''
		self.value.to_s << type
	end

	def coupon_label_method
		type = self.offer_type == 2 ? ' Termék' : 'Összeg'
		self.offer_type = type
	end

	def order_item_label_method
		self.product.name
	end

	def order_label_method
		self.user.title_name + " " + self.user.first_name + " " + self.user.last_name + " - " + self.created_at.to_s
	end

	def link_label_method
		self.link_text
	end

	def store_label_method
		self.name
	end

	def user_label_method
		self.title_name + " " + self.first_name + " " + self.last_name
	end

	def address_label_method
		self.zip + " " + self.city + ", " + self.additional
	end

end

class ProductTranslation < ActiveRecord::Base
	belongs_to :product

	validates :product_id, :locale, :short_description, :long_description, :advice, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

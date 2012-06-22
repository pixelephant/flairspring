class PropertyCategoryTranslation < ActiveRecord::Base
	belongs_to :property_category

	validates :property_category_id, :locale, :category_name, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

class CustomCategoryTranslation < ActiveRecord::Base
	belongs_to :custom_category

	validates :custom_category_id, :locale, :name, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

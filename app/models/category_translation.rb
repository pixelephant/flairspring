class CategoryTranslation < ActiveRecord::Base
	belongs_to :category

	validates :category_id, :locale, :name, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

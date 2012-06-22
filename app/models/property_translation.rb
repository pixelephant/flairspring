class PropertyTranslation < ActiveRecord::Base
	belongs_to :property

	validates :property_id, :locale, :property_name, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

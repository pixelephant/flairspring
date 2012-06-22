class ManufacturerTranslation < ActiveRecord::Base
	belongs_to :manufacturer

	validates :manufacturer_id, :locale, :description, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

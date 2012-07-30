class AdvantageTranslation < ActiveRecord::Base
	belongs_to :advantage

	validates :advantage_id, :locale, :name, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

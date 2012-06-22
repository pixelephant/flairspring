class DesignerTranslation < ActiveRecord::Base
	belongs_to :designer

	validates :designer_id, :locale, :description, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

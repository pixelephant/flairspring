class SubcontentTranslation < ActiveRecord::Base
	belongs_to :subcontent

	validates :subcontent_id, :locale, :text, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

class ContentTranslation < ActiveRecord::Base
	belongs_to :content

	validates :content_id, :locale, :text, :presence => true

	def locale_enum
    I18n.available_locales
  end
end

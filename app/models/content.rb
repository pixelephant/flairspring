class Content < ActiveRecord::Base

translates :text

has_many :content_translations, :dependent => :destroy
accepts_nested_attributes_for :content_translations

extend FriendlyId
friendly_id :name, :use => :slugged

has_many :subcontents

validates :name, :presence => true
validates :name, :uniqueness => true

end

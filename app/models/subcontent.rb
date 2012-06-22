class Subcontent < ActiveRecord::Base

translates :text

has_many :subcontent_translations, :dependent => :destroy
accepts_nested_attributes_for :subcontent_translations

extend FriendlyId
friendly_id :name, :use => :slugged

belongs_to :content

validates :name, :text, :presence => true
validates :name, :uniqueness => true

end

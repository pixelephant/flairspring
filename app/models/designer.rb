class Designer < ActiveRecord::Base

	translates :description

	has_many :designer_translations, :dependent => :destroy
	accepts_nested_attributes_for :designer_translations

	has_many :products
	has_many :designer_photos

	belongs_to :brand

	validates :name, :description, :presence => true
end

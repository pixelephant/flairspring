class Manufacturer < ActiveRecord::Base

	translates :description

	has_many :description_translations, :dependent => :destroy
	accepts_nested_attributes_for :description_translations

	has_many :products
	has_many :manufacturer_photos

	validates :name, :description, :presence => true
end

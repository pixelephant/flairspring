class Advantage < ActiveRecord::Base

	translates :name

	has_many :advantage_translations, :dependent => :destroy
	accepts_nested_attributes_for :advantage_translations

	has_many :products, :through => :advantages_to_products
	has_many :advantages_to_products

	validates :name, :presence => true

	validates :name, :uniqueness => true
end

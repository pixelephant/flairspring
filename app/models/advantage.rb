class Advantage < ActiveRecord::Base

	translates :advantage

	has_many :advantage_translations, :dependent => :destroy
	accepts_nested_attributes_for :advantage_translations

	has_many :products, :through => :advantages_to_products
	has_many :advantages_to_products

	validates :advantage, :presence => true

	validates :advantage, :uniqueness => true
end

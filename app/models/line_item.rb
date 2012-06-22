class LineItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :cart

	has_many :properties_to_line_items
	has_many :properties, :through => :properties_to_line_items

	accepts_nested_attributes_for :properties
end

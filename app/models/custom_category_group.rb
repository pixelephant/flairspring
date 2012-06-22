class CustomCategoryGroup < ActiveRecord::Base
	translates :name

	has_many :custom_category_group_translations, :dependent => :destroy
	accepts_nested_attributes_for :custom_category_group_translations

	has_many :custom_categories
	has_and_belongs_to_many :categories
end

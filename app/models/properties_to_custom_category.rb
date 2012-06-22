class PropertiesToCustomCategory < ActiveRecord::Base
	belongs_to :property
	belongs_to :custom_category
end

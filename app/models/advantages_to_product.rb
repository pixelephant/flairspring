class AdvantagesToProduct < ActiveRecord::Base
	belongs_to :product
	belongs_to :advantage

	validates :advantage_id, :product_id, :presence => true

	validates :advantage_id, :uniqueness => { :scope => :product_id,
    :message => "Existing relation" }
end

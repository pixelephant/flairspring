class Photo < ActiveRecord::Base
	belongs_to :product
	mount_uploader :image_file, ImageUploader

	validates :product_id, :image_file, :alt, :presence => true

	validates :image_file, :uniqueness => true
end

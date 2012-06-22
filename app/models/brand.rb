class Brand < ActiveRecord::Base

	mount_uploader :image_file, ImageUploader
	mount_uploader :small_image_file, ImageUploader

	has_many :products
	has_many :designers
end

class ManufacturerPhoto < ActiveRecord::Base
	belongs_to :manufacturer

	mount_uploader :image_file, ImageUploader

	validates :manufacturer_id, :image_file, :alt, :presence => true
	validates :image_file, :uniqueness => true
end

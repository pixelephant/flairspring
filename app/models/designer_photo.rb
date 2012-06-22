class DesignerPhoto < ActiveRecord::Base
	belongs_to :designer

	mount_uploader :image_file, ImageUploader

	validates :designer_id, :image_file, :alt, :presence => true
	validates :image_file, :uniqueness => true
end

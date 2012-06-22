class MassUpload < ActiveRecord::Base
	mount_uploader :filename, AssetUploader
end

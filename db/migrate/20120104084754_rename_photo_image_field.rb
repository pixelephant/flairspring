class RenamePhotoImageField < ActiveRecord::Migration
  def change
		change_table :photos do |t|
      t.rename :image, :image_file
		end
  end
end

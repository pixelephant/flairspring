class RenameColumnInPhotos < ActiveRecord::Migration
  def change
		change_table :photos do |t|
      t.rename :image_url, :image
		end
  end
end

class AddSmallImageFileToBrands < ActiveRecord::Migration
  def change
  	add_column :brands, :small_image_file, :string
  end
end

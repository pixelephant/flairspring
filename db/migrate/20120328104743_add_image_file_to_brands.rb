class AddImageFileToBrands < ActiveRecord::Migration
  def change
  	add_column :brands, :image_file, :string
  end
end

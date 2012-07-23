class AddImageFileToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :image_file, :string
  end
end

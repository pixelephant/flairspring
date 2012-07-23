class AddImageFileToCustomCategory < ActiveRecord::Migration
  def change
  	add_column :custom_categories, :image_file, :string
  end
end

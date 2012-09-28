class AddProductPageImageToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :product_page_image, :string
  end
end

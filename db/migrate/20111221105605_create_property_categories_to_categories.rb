class CreatePropertyCategoriesToCategories < ActiveRecord::Migration
  def change
    create_table :property_categories_to_categories do |t|
      t.integer :property_category_id, :null => false
      t.integer :category_id, :null => false

      t.timestamps
    end
  end
end

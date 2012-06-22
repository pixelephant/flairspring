class CreatePropertiesToCategories < ActiveRecord::Migration
  def change
    create_table :properties_to_categories do |t|
      t.integer :property_id, :null => false
      t.integer :category_id, :null => false

      t.timestamps
    end
  end
end

class CreatePropertiesToCustomCategories < ActiveRecord::Migration
  def change
    create_table :properties_to_custom_categories do |t|
      t.integer :custom_category_id
      t.integer :property_id

      t.timestamps
    end
  end
end

class CreatePropertiesToProducts < ActiveRecord::Migration
  def change
    create_table :properties_to_products do |t|
      t.integer :property_id, :null => false
      t.integer :product_id, :null => false

      t.timestamps
    end
  end
end

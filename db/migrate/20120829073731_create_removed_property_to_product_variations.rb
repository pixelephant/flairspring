class CreateRemovedPropertyToProductVariations < ActiveRecord::Migration
  def change
    create_table :removed_property_to_product_variations do |t|
      t.integer :product_variation_id
      t.integer :property_id

      t.timestamps
    end
  end
end

class CreateProductSetsProperties < ActiveRecord::Migration
  def change
    create_table :product_sets_properties do |t|
      t.integer :product_set_id
      t.integer :property_id

      t.timestamps
    end
  end
end

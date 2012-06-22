class CreateProductSetsProducts < ActiveRecord::Migration
  def change
    create_table :product_sets_products do |t|
      t.integer :product_id
      t.integer :product_set_id

      t.timestamps
    end
  end
end

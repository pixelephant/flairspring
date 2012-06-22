class CreateProductsStores < ActiveRecord::Migration
  def change
    create_table :products_stores do |t|
      t.integer :store_id
      t.integer :product_id

      t.timestamps
    end
  end
end

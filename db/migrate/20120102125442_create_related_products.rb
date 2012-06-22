class CreateRelatedProducts < ActiveRecord::Migration
  def change
    create_table :related_products do |t|
      t.integer :product_id, :null => false
      t.integer :related_product_id, :null => false

      t.timestamps
    end
  end
end

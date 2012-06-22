class CreateDiscountsToProducts < ActiveRecord::Migration
  def change
    create_table :discounts_to_products do |t|
      t.integer :product_id, :null => false
      t.integer :discount_id, :null => false

      t.timestamps
    end
  end
end

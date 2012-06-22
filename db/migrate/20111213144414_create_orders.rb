class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :shipping_address_id
      t.integer :invoice_address_id
      t.integer :user_id
      t.text :basket_serialization

      t.timestamps
    end
  end
end

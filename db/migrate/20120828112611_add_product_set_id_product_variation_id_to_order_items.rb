class AddProductSetIdProductVariationIdToOrderItems < ActiveRecord::Migration
  def change
  	add_column :order_items, :product_variation_id, :integer
  	add_column :order_items, :product_set_id, :integer
  end
end

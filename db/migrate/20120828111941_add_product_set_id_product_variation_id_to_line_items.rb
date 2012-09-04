class AddProductSetIdProductVariationIdToLineItems < ActiveRecord::Migration
  def change
  	add_column :line_items, :product_variation_id, :integer
  	add_column :line_items, :product_set_id, :integer
  end
end

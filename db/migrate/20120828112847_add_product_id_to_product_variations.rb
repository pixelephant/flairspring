class AddProductIdToProductVariations < ActiveRecord::Migration
  def change
  	add_column :product_variations, :product_id, :integer
  end
end

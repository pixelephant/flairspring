class AddBrandIdToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :brand_id, :integer
  end
end

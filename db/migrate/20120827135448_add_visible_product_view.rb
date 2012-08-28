class AddVisibleProductView < ActiveRecord::Migration
  def change
  	add_column :property_categories, :visible_product_view, :boolean, :default => 1
  end
end

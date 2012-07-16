class AddVisibleToPropertyCategories < ActiveRecord::Migration
  def change
  	add_column :property_categories, :visible, :boolean, :default => 1
  end
end

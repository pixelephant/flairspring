class AddBrandToDesigner < ActiveRecord::Migration
  def change
  	remove_column :designers, :brand
  	add_column :designers, :brand_id, :integer
  end
end

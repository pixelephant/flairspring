class RenamePropertyAndProductAssociationTable < ActiveRecord::Migration
  def up
		rename_table :properties_to_products, :products_properties
  end

  def down
		rename_table :products_properties, :properties_to_products
  end
end

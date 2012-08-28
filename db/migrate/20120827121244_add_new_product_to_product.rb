class AddNewProductToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :new_product, :boolean, :default => 0
  end
end

class AddDeliveryTimeToBrands < ActiveRecord::Migration
  def change
  	add_column :brands, :on_stock, :string
  	add_column :brands, :out_stock, :string
  end
end

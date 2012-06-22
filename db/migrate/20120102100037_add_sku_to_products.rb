class AddSkuToProducts < ActiveRecord::Migration
  def up
		change_table :products do |t|
      t.string :sku, :null => false, :unique => true
		end
  end

	def down
		remove_column :products, :sku
	end
end

class AddManufacturerAndDesignerToProduct < ActiveRecord::Migration
	def up
		change_table :products do |t|
      t.integer :designer_id, :null => false
      t.integer :manufacturer_id, :null => false
		end
  end

	def down
		remove_column :products, :manufacturer_id
		remove_column :products, :designer_id
	end
end

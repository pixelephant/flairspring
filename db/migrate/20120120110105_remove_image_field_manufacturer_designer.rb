class RemoveImageFieldManufacturerDesigner < ActiveRecord::Migration
  def down
		change_table :designers do |t|
      t.integer :image
		end
		change_table :manufacturers do |t|
      t.integer :image
		end
  end

	def up
		remove_column :designers, :image
		remove_column :manufacturers, :image
  end
end

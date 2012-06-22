class RemoveParentChildFromCategories < ActiveRecord::Migration
  def up
		remove_column :categories, :category_id
  end

  def down
		change_table :categories do |t|
      t.integer :category_id, :null => false
		end
  end
end

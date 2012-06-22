class AddCategoryToCustomCategory < ActiveRecord::Migration
	def up
		change_table :custom_categories do |t|
      t.integer :category_id, :null => false
		end
  end

	def down
		remove_column :custom_categories, :category_id
  end
end

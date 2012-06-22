class AddDiscountToCategoryAndCustomCategory < ActiveRecord::Migration
  def up
		change_table :categories do |t|
      t.integer :discount_id
		end
		change_table :custom_categories do |t|
      t.integer :discount_id
		end
  end

	def down
		remove_column :categories, :discount_id
		remove_column :custom_categories, :discount_id
  end
end

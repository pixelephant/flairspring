class CreateCategoriesCustomCategories < ActiveRecord::Migration
  def change
    create_table :categories_custom_category_groups do |t|
      t.integer :category_id
      t.integer :custom_category_group_id
      t.timestamps
    end
  end
end

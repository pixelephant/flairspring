class AddCustomCategoryGroupToCustomCategory < ActiveRecord::Migration
  def change
  	add_column :custom_categories, :custom_category_group_id, :integer
  end
end

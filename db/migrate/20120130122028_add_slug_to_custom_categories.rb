class AddSlugToCustomCategories < ActiveRecord::Migration
	def change
    add_column :custom_categories, :slug, :string
		add_index :custom_categories, :slug
  end
end

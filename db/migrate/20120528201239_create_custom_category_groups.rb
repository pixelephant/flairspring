class CreateCustomCategoryGroups < ActiveRecord::Migration
  def up
    create_table :custom_category_groups do |t|
    	t.integer :id
      t.string :name

      t.timestamps
    end
    CustomCategoryGroup.create_translation_table! :name => :string
  end
  def down
    drop_table :custom_category_groups
    CustomCategoryGroup.drop_translation_table!
  end
end

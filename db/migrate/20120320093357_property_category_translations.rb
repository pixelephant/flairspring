class PropertyCategoryTranslations < ActiveRecord::Migration
  def up
		PropertyCategory.create_translation_table!({
      :category_name => :string,
    }, {
      :migrate_data => true
    })
  end

  def down
		PropertyCategory.drop_translation_table! :migrate_data => true
  end
end

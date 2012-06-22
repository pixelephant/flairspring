class CreateCustomCategoryGroupTranslations < ActiveRecord::Migration
  def up
    CustomCategoryGroup.create_translation_table!({
      :name => :string
    }, {
      migrate_data: true
    })
  end

  def down
    CustomCategoryGroup.drop_translation_table! migrate_data: true
  end
end

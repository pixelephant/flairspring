class CustomCategoryTranslation < ActiveRecord::Migration
  def up
    CustomCategory.create_translation_table!({
      :name => :string
    }, {
      migrate_data: true
    })
  end

  def down
    CustomCategory.drop_translation_table! migrate_data: true
  end
end

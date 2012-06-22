class DesignerTranslations < ActiveRecord::Migration
  def up
		Designer.create_translation_table!({
			:description => :text
    }, {
      :migrate_data => true
    })
  end

  def down
		Designer.drop_translation_table! :migrate_data => true
  end
end

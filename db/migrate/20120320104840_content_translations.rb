class ContentTranslations < ActiveRecord::Migration
  def up
  	Content.create_translation_table!({
			:text => :text
    }, {
      :migrate_data => true
    })
  end

  def down
		Content.drop_translation_table! :migrate_data => true
  end
end

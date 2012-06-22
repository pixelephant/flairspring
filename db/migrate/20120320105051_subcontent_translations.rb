class SubcontentTranslations < ActiveRecord::Migration
  def up
  	Subcontent.create_translation_table!({
			:text => :text
    }, {
      :migrate_data => true
    })
  end

  def down
		Subcontent.drop_translation_table! :migrate_data => true
  end
end

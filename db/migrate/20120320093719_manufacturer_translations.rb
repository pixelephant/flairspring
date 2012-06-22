class ManufacturerTranslations < ActiveRecord::Migration
  def up
		Manufacturer.create_translation_table!({
			:description => :text
    }, {
      :migrate_data => true
    })
  end

  def down
		Manufacturer.drop_translation_table! :migrate_data => true
  end
end

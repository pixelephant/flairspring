class ProductTranslations < ActiveRecord::Migration
  def up
		Product.create_translation_table!({
      :short_description => :text,
      :long_description => :text,
			:advice => :text
    }, {
      :migrate_data => true
    })
  end

  def down
		Product.drop_translation_table! :migrate_data => true
  end
end

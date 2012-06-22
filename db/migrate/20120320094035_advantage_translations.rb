class AdvantageTranslations < ActiveRecord::Migration
  def up
  Advantage.create_translation_table!({
			:advantage => :string
    }, {
      :migrate_data => true
    })
  end

  def down
		Advantage.drop_translation_table! :migrate_data => true
  end
end

class CreatePropertiesToLineItems < ActiveRecord::Migration
  def change
    create_table :properties_to_line_items do |t|
      t.integer :line_item_id
      t.integer :property_id

      t.timestamps
    end
  end
end

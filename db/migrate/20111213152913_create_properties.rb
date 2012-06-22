class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :property_name, :null => false
      t.integer :property_category_id

      t.timestamps
    end
  end
end

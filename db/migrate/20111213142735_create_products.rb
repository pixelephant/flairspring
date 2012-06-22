class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, :null => false, :unique => true
      t.string :short_description
      t.text :long_description
      t.integer :category_id, :null => false

      t.timestamps
    end
  end
end

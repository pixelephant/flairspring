class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :product_id
      t.string :image_url, :null => false, :unique => true
      t.string :alt, :null => false
      t.boolean :default

      t.timestamps
    end
  end
end

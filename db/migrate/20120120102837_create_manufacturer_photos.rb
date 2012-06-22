class CreateManufacturerPhotos < ActiveRecord::Migration
  def change
    create_table :manufacturer_photos do |t|
      t.integer :manufacturer_id
      t.string :image_file
      t.string :alt

      t.timestamps
    end
  end
end

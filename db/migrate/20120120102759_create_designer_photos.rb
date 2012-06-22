class CreateDesignerPhotos < ActiveRecord::Migration
  def change
    create_table :designer_photos do |t|
      t.integer :designer_id
      t.string :image_file
      t.string :alt

      t.timestamps
    end
  end
end

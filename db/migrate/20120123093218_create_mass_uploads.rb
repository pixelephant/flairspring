class CreateMassUploads < ActiveRecord::Migration
  def change
    create_table :mass_uploads do |t|
      t.string :filename

      t.timestamps
    end
  end
end

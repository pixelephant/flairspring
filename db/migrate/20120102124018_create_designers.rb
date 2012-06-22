class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|
      t.string :name, :null => false, :unique => true
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end

class CreateSubcontents < ActiveRecord::Migration
  def change
    create_table :subcontents do |t|
      t.integer :content_id
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end

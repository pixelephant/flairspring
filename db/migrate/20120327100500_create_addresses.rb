class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :zip
      t.string :city
      t.string :additional

      t.timestamps
    end
  end
end

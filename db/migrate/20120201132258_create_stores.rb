class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :lat
      t.string :long

      t.timestamps
    end
  end
end

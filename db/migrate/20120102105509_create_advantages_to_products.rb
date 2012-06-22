class CreateAdvantagesToProducts < ActiveRecord::Migration
  def change
    create_table :advantages_to_products do |t|
      t.integer :product_id, :null => false
      t.integer :advantage_id, :null => false

      t.timestamps
    end
  end
end

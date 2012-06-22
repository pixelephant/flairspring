class CreateProductSets < ActiveRecord::Migration
  def change
    create_table :product_sets do |t|
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end

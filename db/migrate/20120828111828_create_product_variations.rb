class CreateProductVariations < ActiveRecord::Migration
  def change
    create_table :product_variations do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end

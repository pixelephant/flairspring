class CreateLinksProducts < ActiveRecord::Migration
  def change
    create_table :links_products do |t|
      t.integer :link_id
      t.integer :product_id

      t.timestamps
    end
  end
end

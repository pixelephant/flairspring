class CreateWishlistItems < ActiveRecord::Migration
  def change
    create_table :wishlist_items do |t|
      t.integer :wishlist_id
      t.integer :product_id
      t.boolean :sold

      t.timestamps
    end
  end
end

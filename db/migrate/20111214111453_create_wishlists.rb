class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.string :custom_url
      t.integer :user_id
      t.boolean :public

      t.timestamps
    end
  end
end

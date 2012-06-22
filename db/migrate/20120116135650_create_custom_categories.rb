class CreateCustomCategories < ActiveRecord::Migration
  def change
    create_table :custom_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

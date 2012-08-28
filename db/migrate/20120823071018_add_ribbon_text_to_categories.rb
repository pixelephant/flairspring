class AddRibbonTextToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :ribbon_text, :string
  end
end

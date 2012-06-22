class AddBrandToDesigners < ActiveRecord::Migration
  def change
  	add_column :designers, :brand, :string
  end
end

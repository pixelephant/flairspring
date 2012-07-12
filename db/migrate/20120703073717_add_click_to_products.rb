class AddClickToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :click, :integer, :default => 0
  end
end

class AddVisibleToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :visible, :boolean, :default => 1
  end
end

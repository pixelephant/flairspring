class AddNumericToProperties < ActiveRecord::Migration
  def change
  	add_column :properties, :numeric, :float
  end
end

class AddNameFieldsToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :name
  	add_column :users, :title_name, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  end
end

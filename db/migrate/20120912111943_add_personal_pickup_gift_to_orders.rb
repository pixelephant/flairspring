class AddPersonalPickupGiftToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :personal_pickup, :boolean
  	add_column :orders, :gift, :boolean
  end
end

class AddOrderIdToCoupon < ActiveRecord::Migration
  def change
  	add_column :coupons, :order_id, :integer
  end
end

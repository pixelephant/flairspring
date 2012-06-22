class RenameDiscountTypeColumn < ActiveRecord::Migration
	def change
		change_table :discounts do |t|
      t.rename :discountType, :discount_type
		end
  end
end

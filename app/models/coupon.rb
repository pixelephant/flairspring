class Coupon < ActiveRecord::Base

	belongs_to :order

	def coupon_value(cart)
		discount = 0
		discount = self.offer_value if self.offer_type == 1
		discount = Product.find(self.offer_value).full_price if self.offer_type == 2 && Cart.find(cart).line_items.where(:product_id => self.offer_value).any?
		return discount
	end

end

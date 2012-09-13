#encoding: utf-8
class Coupon < ActiveRecord::Base

	belongs_to :order

	#Értékek:
	# 1 - Összeg
	# 2 - Termék
	# 3 - Százalék

	def coupon_value(cart)
		puts self.offer_value
		puts self.offer_type
		discount = 0
		discount = self.offer_value if self.offer_type == 1
		discount = cart.total * (self.offer_value.to_i/100) if self.offer_type == 3
		discount = Product.find(self.offer_value).full_price if self.offer_type == 2 && Cart.find(cart).line_items.where(:product_id => self.offer_value).any?
		return discount
	end

	def offer_type_enum
    [ [ 'Összeg', '1' ], [ 'Termék', '2' ], [ 'Százalék', '3' ] ]
  end

end

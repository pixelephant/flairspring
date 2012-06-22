module ProductsHelper

	def productPrice(product_id)
		p = Product.find(product_id)

		if p.price.blank?
			return ''
		end
		price = p.price

		#Product discount factor
		p.discounts.each do |d|
			if d.discount_type == 1
				price = price - d.value
			end

			if d.discount_type == 2
				price = price - (price * (d.value.to_f / 100))
			end
		end

		return price.round if price < p.price

		#Custom category discount factor

#		if p.custom_category.any?
#			p.custom_category.discount.each do |d|
#				if d.discount_type == 1
#					price = price - d.value
#				end
#
#				if d.discount_type == 2
#					price = price - (price * (d.value.to_f / 100))
#				end
#			end
#		end

#		return price.round if price < p.price

		#Category discount factor
		if !p.category.discount.nil?
			p.category.discount.each do |d|
				if d.discount_type == 1
					price = price - d.value
				end

				if d.discount_type == 2
					price = price - (price * (d.value.to_f / 100))
				end
			end

			return price.round if price < p.price
		end
		return price
	end

end

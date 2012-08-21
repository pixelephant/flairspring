module ApplicationHelper
#encoding: utf-8

#
# Converts the given HASH array like 'params' to a flat
# HASH array that's compatible with url_for and link_to
#
def flatten_param_hash( params )
  found = true

  while found
    found = false
    new_hash = {}

    params.each do |key,value|
      if value.is_a?( Hash )
        found = true
        value.each do |key2,value2|
          new_hash[ key.to_s + '[' + key2.to_s + ']' ] = value2
        end
      else
        new_hash[ key.to_s ] = value
      end
    end
    params = new_hash
  end
  params
end

#CustomCategoryFilterben
def property_disabled?(property,params,fix_properties)

	return false if property.blank? || params.blank? || fix_properties.blank?

	value = (params[property.property_category.id.to_s].include?(property.id.to_s) ? true : false) if params[property.property_category.id.to_s]
	value2 = (fix_properties[property.property_category.id].include?(property.id) ? true : false) if fix_properties[property.property_category.id]

	return value || value2
end


	#Devise login
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  #Devise login end


	def box_class(number)
		cl = ""
		cl = " mid" if number == 1
		cl = " last" if number == 2
		cl
	end

	def product_has_property(property_id, product_id)
		Product.find(product_id).properties.where(:id => property_id).exists?
	end

	def is_active_category_with_index?(page_name, index)
		cl = []
    cl << 'active' if params[:id] == page_name
		cl << 'first' if index == 0
		cl << 'last' if (Category.count && !Content.all.any?) == index + 1

		return raw ' class="' << cl.join(" ") << '"'
  end

	def is_a_number?(s)
		s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end

	def cart_count
		if Cart.exists?(session[:cart_id])
			cart = Cart.find(session[:cart_id])
			count = 0
			cart.line_items.each do |item|
				count += item.quantity
			end
		count
		else
			nil
		end
	end

	def cart_subtotal
		if Cart.exists?(session[:cart_id])
			cart = Cart.find(session[:cart_id])
			subtotal = 0
			cart.line_items.each do |item|
				subtotal += (item.quantity * item.product.full_price)
			end
		subtotal
		else
			nil
		end
	end

	def cart_shipping
		if cart_subtotal.nil?
			return 0
		else
			return 1000
		end
	end

	def lead(string)
		return '' if string.blank?
		s = string.split(' ', 5)
		if s.length > 4
			i = s[0..3].join(" ")
			e = s[4]
		else
			i = s.join(" ")
			e = ''
		end
		'<span class="lead">' + i.to_s + '</span> ' + e.to_s
	end

	def product_ribbon(product)
		tag = ""

		tag = "Uj" if product.new?
		tag = "Akcios" if product.on_sale?

		return '<div class="ribbon"><p>' + tag + '</p></div>' unless tag == ''
	end

end

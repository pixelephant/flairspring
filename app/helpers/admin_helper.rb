module AdminHelper
	def user_full_address(user_id)
		address = User.find(user_id).user_addresses.first
		return address.zip + " " + address.city + ", " + address.street + " " + address.additional
	end
end

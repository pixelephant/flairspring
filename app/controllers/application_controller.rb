class ApplicationController < ActionController::Base
  protect_from_forgery
	#before_filter :set_i18n_locale_from_params

  layout "application"

	private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
		if current_user.try(:admin?)
			"/"
		else
			"/"
		end
  end

	def after_sign_in_path_for(resource_or_scope)
		if current_user.try(:admin?)
			admin_path
		else
			if current_cart.line_items.any?
				"/" + I18n.locale.to_s + "/checkout"
			else
				"/"
			end
		end
  end


	def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end

	#I18n
	def set_i18n_locale_from_params
		if params[:locale]
			if I18n.available_locales.include?(params[:locale].to_sym)
				I18n.locale = params[:locale]
			else
				logger.error "No available_locales"
			end
		else
			I18n.locale = I18n.default_locale
		end
	end

	# def default_url_options
	# 	{ :locale => I18n.locale }
	# end

end
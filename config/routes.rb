Madearthome::Application.routes.draw do

  resources :product_sets

	#Admin

	devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

	post 'admin/parse_save_from_excel' => "admin_custom#parse_save_from_excel"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "admin/index"

	match "admin" => 'admin#index'

	match "comingsoon" => "comingsoon#index"
	match "adatvedelem" => "comingsoon#how"
	match "sajtoanyagok" => "comingsoon#sajtoanyagok"

	resources :comingsoon

	#Admin ajax routes START

	post 'admin_ajax/getcategoryproperties' => "admin_ajax#getCategoryProperties"

	#Admin ajax routes END

	#Admin end

	#Ajax routes START
	post 'home/language' => "home#language"

	post 'cart/remove_item' => "cart#remove_item"
	post 'cart/personal' => "cart#personal"

	post 'products/add_to_wishlist' => 'products#add_to_wishlist'
	post 'products/remove_from_wishlist' => 'products#remove_from_wishlist'
	post 'products/buy_from_wishlist' => 'products#buy_from_wishlist'

	post 'cart/coupon' => 'cart#coupon'
	post 'checkout/regisztralok' => 'checkout#lazy_registration'

	post 'wishlists/publish' => 'wishlists#publish'
	#Ajax routes END

	#Categories START
	#match "/:id" => "categories#show"
	#Categories END

	# Nyelv eleje
	# scope '(:locale)/', :shallow_path => "(:locale)", :locale => /en|hu/ do

		match 'wishlist' => 'users#account'
		match 'fiokom' => 'users#account'

		# match 'category' => "categories#index"

		match 'test-subcontent' => "subcontents#testsubcontent"
		match 'subcontent2' => "subcontents#subcontent2"

		match 'kereses' => 'search#index'

		get 'products/quicklook/:id' => "products#quicklook"

		#resources :links_products

		match 'rolunk' => "about#index"

		#resources :about

		resources :products_stores

		match 'brand/la-z-boy' => 'brand#lazboy', :as => :lazboy

		match 'brand/uttermost' => 'brand#uttermost', :as => :uttermost

		#resources :brands

		resources :ad

		resources :stores

		resources :links

    resources :comingsoon

    match 'checkout/billing_shipping' => 'checkout#billing_shipping'

    post 'checkout/payment' => 'checkout#payment'

    match 'checkout/payment' => 'checkout#payment'

    match 'checkout/thankyou' => 'checkout#thankyou'

    match 'cart' => 'cart#index'

    match 'megrendeleseim/:id' => 'orders#myorder'

    resources :checkout

		resources :line_items

		#resources :carts

		#resources :cart

		resources :manufacturer_photos

		resources :designer_photos

		resources :discounts

		resources :designers

		#resources :manufacturers

		#resources :wishlist_items

		resources :wishlists

		resources :order_items

		resources :orders

		resources :user_addresses

    match 'users/register' => 'users#register'

		#resources :users

		resources :photos

		resources :products

		# match "(:locale/):category_id/:id" => 'custom_categories#show', :as => :custom_category

		# match "(:locale/):id" => 'categories#show', :as => :category

		# match ":category_id/osszes" => 'custom_categories#show', :as => :custom_category

		match ":category_id/:id" => 'custom_categories#show', :as => :custom_category

		# match ":id" => 'categories#show', :as => :category
		match ":id" => 'categories#index', :as => :category

		# resources :categories do
		# 	resources :custom_categories, :as => :custom_category
		# end

		#get "home/index"

		root :to => 'home#index', :as => 'index'

	#end
	#Nyelv vége

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

	# DEVISE

	# DEVISE END

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'home#index', :as => 'index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

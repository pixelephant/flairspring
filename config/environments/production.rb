Madearthome::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )
  config.assets.precompile += ['about.js', 'admin.js', 'admin_ajax.js', 'admin_custom.js', 'advantages.js', 'brand.js', 'carousel.js', 'cart.js', 'categories.js', 'checkout.js', 'custom_categories.js', 'designers.js', 'discounts.js', 'home.js', 'jquery.easing.js', 'jquery.easytabs.min.js', 'jquery.fancybox.js', 'jquery.prettyLoader.js', 'jquery.slider.min.js', 'jquery.tooltip.js', 'jquery.validate', 'mousewheel.js', 'orders.js', 'photos.js', 'products.js', 'properties.js', 'registration.js', 'search.js', 'sessions.js', 'simplyscroll.js', 'users.js', 'video.min.js', 'wishlists.js', 'zoom.js']
  config.assets.precompile += ['about.css', 'ad.css', 'brand.css', 'categories.css', 'checkout.css', 'custom_categories.css', 'designers.css', 'discounts.css', 'fancybox.css', 'home.css', 'orders.css', 'photos.css', 'prettyLoader.css', 'products.css', 'properties.css', 'registrations.css', 'scaffolds.css', 'search.css', 'users.css', 'video.min.css', 'wishlists.css']

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
end

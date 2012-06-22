class AdminController < ApplicationController
  def index
		@products = Product.all
		@users = User.all
  end
end

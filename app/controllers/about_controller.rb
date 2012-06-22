class AboutController < ApplicationController
  layout "application"

  def index
  	@description = ""
  	@keywords = ""

	 render "index"
  end
  
end

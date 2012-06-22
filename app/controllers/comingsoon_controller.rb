class ComingsoonController < ApplicationController

  caches_page :index, :how, :sajtoanyagok

  layout "comingsoon"

  def index
		render "index"
  end

  def how
		render "how"
  end

  def sajtoanyagok
		render "sajtoanyagok"
  end
end

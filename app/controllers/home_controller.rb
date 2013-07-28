class HomeController < ApplicationController
  layout "home_index", only: :index
  def index
  end
  def about
  end
end

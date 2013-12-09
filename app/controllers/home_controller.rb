class HomeController < ApplicationController
  def index
    @period = Period.last
  end
end

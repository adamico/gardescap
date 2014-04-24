class HomeController < ApplicationController
  before_action :set_period

  def index
    authorize! :index, :home
  end

  def stats
    authorize! :stats, :home
  end

  private

  def set_period
    @period = Period.last
  end
end

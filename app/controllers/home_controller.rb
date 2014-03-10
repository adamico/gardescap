class HomeController < ApplicationController
  before_action :set_period

  def index
    authorize! :index, :home
  end

  def stats
    authorize! :stats, :home
    @medecins = User.all
  end

  private

  def set_period
    @period = Period.last
  end
end

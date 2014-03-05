class HomeController < ApplicationController
  before_action :set_period

  def index
  end

  def stats
    @medecins = ActsAsTaggableOn::Tag.order(:name).all.map(&:name)
  end

  private

  def set_period
    @period = Period.last
  end
end

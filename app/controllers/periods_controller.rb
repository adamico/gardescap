class PeriodsController < ApplicationController
  def show
    @period = params[:id].present? ? Period.find(params[:id]) : Period.last
  end
end

class PeriodsController < ApplicationController
  helper_method :xeditable?

  def show
    @period = params[:id].present? ? Period.find(params[:id]) : Period.last
    @gardes = @period.gardes
    @mois_gardes = @gardes.group_by {|garde| garde.date.month}
    @mois = @period.mois
  end

  private

  def xeditable?
    true
  end
end

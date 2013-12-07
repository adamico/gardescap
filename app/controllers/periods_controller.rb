class PeriodsController < ApplicationController
  helper_method :xeditable?

  def show
    @period = params[:id].present? ? Period.find(params[:id]) : Period.last
    @gardes = @period.gardes
    @mois_gardes = @gardes.group_by {|garde| I18n.l(garde.date, format: :month_only)}
    @mois = @mois_gardes.keys
  end

  private

  def xeditable?
    true
  end
end

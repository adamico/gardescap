class PeriodsController < ApplicationController
  helper_method :xeditable?

  def show
    @period = params[:id].present? ? Period.find(params[:id]) : Period.last
    @gardes = @period.gardes
    @mois_gardes = @gardes.group_by {|garde| garde.date.month}
    @mois = @period.mois
  end

  def populate
    @period = Period.find(params[:id])
    @period.create_gardes
    redirect_to @period, notice: "Le tableau a été prerempli avec les gardes, veuillez rajouter manuellement les jours fériés."
  end

  private

  def xeditable?
    true
  end
end

class PeriodsController < ApplicationController
  helper_method :xeditable?
  respond_to :html, :json
  respond_to :xls, only: :show
  load_and_authorize_resource

  def show
    @period = params[:id].present? ? Period.find(params[:id]) : Period.last
    @gardes = @period.gardes
    @mois_gardes = @gardes.group_by {|garde| garde.date.month}
    @mois = @period.mois
    respond_with @period
  end

  def new
  end

  def edit
  end

  def update
    @period.update(period_params)
    respond_with @period
  end

  def create
    @period.create(period_params)
    respond_with @period
  end

  def populate
    @period = Period.find(params[:id])
    @period.create_gardes
    redirect_to choix_path, notice: "Le tableau a été prerempli avec les gardes, veuillez rajouter manuellement les jours fériés."
  end

  private

  def period_params
    params.require(:period).permit(:starts_at, :ends_at, :state)
  end

  def xeditable?
    true
  end
end

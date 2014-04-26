class GardesController < ApplicationController
  respond_to :js, only: [:create, :update, :destroy]
  respond_to :html
  load_and_authorize_resource

  def show
    @activities = PublicActivity::Activity.where(trackable_id: [@garde.assignment_ids]) if @garde.assignments.any?
  end

  def create
    @garde = Garde.create(garde_params)
    respond_to do |format|
      format.js
      format.html { redirect_to choix_path }
    end
  end

  def update
    @garde.update(garde_params)
    respond_to do |format|
      format.js
      format.html { redirect_to choix_path }
    end
  end

  def mass_toggle_holiday
    gardes_to_update = Garde.where(date: (params[:date]..params[:date]))
    new_holiday_value = gardes_to_update.any?(&:holiday?) ? false : true
    gardes_to_update.update_all(holiday: new_holiday_value)
  end

  def destroy
    @garde = Garde.find(params[:id])
    @garde.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to choix_path }
    end
  end

  private

  def garde_params
    params.require(:garde).permit(:holiday, :state)
  end
end

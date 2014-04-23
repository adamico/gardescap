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
    params.require(:garde).permit(:date, :time, :holiday, :period_id)
  end
end

class GardesController < ApplicationController
  respond_to :js, only: [:create, :destroy]
  respond_to :html
  load_and_authorize_resource

  def show
  end

  def create
    @garde = Garde.create(garde_params)
    respond_to do |format|
      format.js
    end
  end

  def update
    @garde.update(garde_params)
    respond_with @garde
  end

  def destroy
    @garde = Garde.find(params[:id])
    @garde.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def garde_params
    params.require(:garde).permit(:date, :time, :period_id)
  end
end

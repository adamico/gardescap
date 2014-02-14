class GardesController < ApplicationController
  respond_to :json, only: [:tags, :update]
  respond_to :js, only: [:create, :destroy]
  respond_to :html
  load_and_authorize_resource

  def tags
    @tags = ActsAsTaggableOn::Tag.named_like(params[:q])
    respond_to do |format|
      format.json do
        tag_list = @tags.any? ? @tags.map {|tag| {id: tag.name, text: tag.name}} : [{id: params[:q], text: params[:q]}]
        render json: tag_list
      end
    end
  end

  def show
  end

  def new
  end

  def create
    @garde = Garde.create(garde_params)
    respond_to do |format|
      format.js
    end
  end

  def update
    @garde.activity_params = {old_candidates: @garde.candidate_list_was.split(", "), new_candidates: garde_params[:candidate_list]}
    @garde.update(garde_params)
    @garde.create_activity :update, owner: current_user
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
    params[:garde] = {candidate_list: []} unless params[:garde].present?
    params.require(:garde).permit(:date, :time, :period_id, candidate_list: [])
  end
end

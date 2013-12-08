class GardesController < ApplicationController
  respond_to :json, only: [:tags, :update]
  respond_to :js, only: :create
  respond_to :html
  load_and_authorize_resource

  def tags
    @tags = ActsAsTaggableOn::Tag.named_like(params[:q])
    respond_to do |format|
      format.json do |format|
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
    @garde.update(garde_params)
    respond_with @garde
  end

  private

  def garde_params
    params.require(:garde).permit(:date, :time, candidate_list: [])
  end
end

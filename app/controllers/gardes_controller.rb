class GardesController < ApplicationController
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

  def update
    @garde = Garde.find(params[:id])
    if @garde.update(garde_params)
      redirect_to gardes_prochain_choix_path, notice: "La garde #{params[:id]} a été mise à jour"
    else
      render :edit
    end
  end

  private

  def garde_params
    params.require(:garde).permit(:candidate_list)
  end
end

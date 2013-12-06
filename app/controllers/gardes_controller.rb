class GardesController < ApplicationController
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

class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  def empty
    PublicActivity::Activity.destroy_all
    redirect_to activities_url, notice: "Le registre a été vidé avec succès."
  end
end

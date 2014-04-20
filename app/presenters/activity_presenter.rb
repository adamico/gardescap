class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity_update
    result = ["le", date, owner, action]
    if garde
      result << link_to_garde
    else
      result << "une garde qui a été enlevée du choix depuis."
    end
    result.join(" ").html_safe
  end

  private

  def date
    content_tag(:small, l(activity.created_at, format: :hhhmm)) + " -"
  end

  def owner
    content_tag(:strong, activity.owner)
  end

  def action
    activity.key == "assignment.destroy" ? "s'est enlevé de" : "a choisi"
  end

  def link_to_garde
    link_to garde.time_date, garde_path(garde), class: "btn btn-default"
  end

  def garde
    begin
      @garde ||= Garde.find(activity.parameters[:garde_id]).time_and_date
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.debug e
      return nil
    end
  end
end

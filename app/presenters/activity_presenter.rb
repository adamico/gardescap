class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity_update
    result = [date, owner]
    if garde
      result += [action, link_to_garde]
    else
      result << "a modifié une garde qui a été enlevé du planning."
    end
    result.join(" ").html_safe
  end

  def action
    activity.key == "assignment.destroy" ? "s'est enlevé de" : "a choisi"
  end

  def date
    content_tag(:small, l(activity.created_at, format: :hhhmm)) + " -"
  end

  def owner
    content_tag(:strong, activity.owner)
  end

  def garde
    @garde ||= Garde.find(activity.parameters[:garde_id])
  end

  def link_to_garde
    link_to garde.time_date, garde_path(garde), class: "btn btn-default"
  end
end

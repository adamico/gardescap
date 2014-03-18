class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity_update
    result = [date, owner]
    if garde
      result += [candidate_changes, link_to_garde, nouvelle_liste]
    else
      result << "a modifié une garde qui a été enlevé du planning."
    end
    result.join(" ").html_safe
  end

  def date
    content_tag(:small, l(activity.created_at, format: :hhhmm)) + " -"
  end

  def owner
    link_to activity.owner, "#"
  end

  def garde
    @garde ||= activity.trackable
  end

  def link_to_garde
    link_to garde.time_date, garde_path(garde), class: "btn btn-default"
  end

  def candidate_changes
    "#{candidates_message} " + content_tag(:span, candidates_list, class: "label label-default") + candidates_message_preposition
  end

  def candidates_message
    candidates_removed? ? "a enlevé" : "a rajouté"
  end

  def candidates_message_preposition
    candidates_removed? ? " de" : " à"
  end

  def candidates_list
    if candidates_removed?
      (old_candidates - new_candidates).map(&:upcase).join(", ")
    else
      (new_candidates - old_candidates).map(&:upcase).join(", ")
    end
  end

  def candidates_removed?
    new_list = new_candidates.length
    old_list = old_candidates.length
    new_list < old_list
  end

  def new_candidates
    activity.parameters[:new_candidates].map(&:upcase)
  end

  def old_candidates
    if activity.parameters[:old_candidates].present?
      activity.parameters[:old_candidates].flatten.map(&:upcase)
    else
      []
    end
  end

  def nouvelle_liste
    liste = new_candidates.empty? ? "aucun candidat" : new_candidates.map {|c| content_tag(:span, c.upcase, class: "label label-default")}.join("&nbsp;")
    "- Nouvelle liste : #{liste}"
  end
end

class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity_update
    [date, owner, candidate_changes, garde_time, garde_date, nouvelle_liste].join(" ").html_safe
  end

  def date
    content_tag(:small, l(activity.created_at, format: :long)) + " -"
  end

  def owner
    link_to activity.owner, "#"
  end

  def garde
    @garde ||= activity.trackable
  end

  def garde_date
    "du #{l garde.date}"
  end

  def garde_time
    Garde::TIMES[garde.time].join(" ")
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
      [old_candidates - new_candidates].flatten.map(&:upcase).join(", ")
    else
      [new_candidates - old_candidates].flatten.map(&:upcase).join(", ")
    end
  end

  def candidates_removed?
    new_list = new_candidates.length
    old_list = old_candidates.length
    new_list < old_list
  end

  def new_candidates
    activity.parameters[:new_candidates]
  end

  def old_candidates
    if activity.parameters[:old_candidates].present?
      activity.parameters[:old_candidates]
    else
      []
    end
  end

  def nouvelle_liste
    liste = garde.candidate_list.empty? ? "aucun candidat" : garde.candidate_list.map {|c| content_tag(:span, c.upcase, class: "label label-default")}.join("&nbsp;")
    "- Nouvelle liste : #{liste}"
  end
end

class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def candidates_changes
    [date, owner, candidate_changes, garde_time, garde_date, nouvelle_liste].join(" ")
  end

  def date
    l(activity.created_at, format: :long)
  end

  def owner
    activity.owner
  end

  def garde
    activity.trackable
  end

  def garde_date
    "du #{l garde.date}"
  end

  def garde_time
    Garde::TIMES[garde.time].join
  end

  def candidate_changes
    "#{candidates_message} " + candidates_list + candidates_message_preposition
  end

  def candidates_message
    candidates_removed? ? "a enlevé" : "a rajouté"
  end

  def candidates_message_preposition
    candidates_removed? ? " de" : " à"
  end

  def candidates_removed?
    new_candidates.length < old_candidates.length
  end

  def candidates_list
    candidates_removed? ? [old_candidates - new_candidates].join(", ") : [new_candidates - old_candidates].join(", ")
  end

  def new_candidates
    activity.parameters[:new_candidates]
  end

  def old_candidates
    activity.parameters[:old_candidates]
  end

  def nouvelle_liste
    liste = garde.candidate_list.empty? ? "aucun candidat" : garde.candidate_list.join(", ")
    "(Nouvelle liste : #{liste})"
  end
end

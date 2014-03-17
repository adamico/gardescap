module AssignmentsHelper
  def candidates_links(garde)
    garde.assignments.map { |assignment| link_to_remove_or_text_for_candidate(assignment) }.join(", ").html_safe if garde.assignments.any?
  end

  def link_to_remove_or_text_for_candidate(assignment)
    if current_user == assignment.user
      link_to_remove_candidate(assignment)
    else
      assignment.user.name
    end
  end

  def link_to_remove_candidate(assignment)
    link_to_if(can?(:destroy, assignment), (assignment.user_name + "&nbsp;" + content_tag(:span, nil, class: "glyphicon glyphicon-remove")).html_safe, assignment_path(assignment), title: "Enlever #{assignment.user_name} de #{assignment.garde.time_and_date}", method: :delete, remote: true, class: "btn btn-sm btn-default") 
  end

  def button_to_choose_garde(garde)
    if garde.candidates_count < Garde::MAX_CANDIDATES
      link_to content_tag(:span, nil, class: "glyphicon glyphicon-ok"), assignments_path(assignment: {garde_id: garde.id, user_id: current_user.id}), method: :post, remote: true, class: "btn btn-default btn-xs create-assignment", title: "Choisir la garde - #{garde.time} - #{l(garde.date)}" unless garde.assignments.where(garde_id: garde.id, user_id: current_user.id).any?
    end
  end
end

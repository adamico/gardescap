module AssignmentsHelper
  def candidates_links(garde)
    garde.assignments.map { |assignment| link_to_if(current_user == assignment.user, (assignment.user.name + "&nbsp;" + content_tag(:span, nil, class: "glyphicon glyphicon-remove")).html_safe, assignment_path(assignment), method: :delete, remote: true, class: "btn btn-sm btn-default") }.join(", ").html_safe if garde.assignments.any?
  end

  def button_to_choose_garde(garde)
    if garde.candidates_count < Garde::MAX_CANDIDATES
      link_to content_tag(:span, nil, class: "glyphicon glyphicon-ok"), assignments_path(assignment: {garde_id: garde.id, user_id: current_user.id}), method: :post, remote: true, class: "btn btn-default btn-xs create-assignment", title: "Choisir la garde - #{garde.time} - #{l(garde.date)}" unless garde.assignments.where(garde_id: garde.id, user_id: current_user.id).any?
    end
  end
end

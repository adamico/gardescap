module AssignmentsHelper
  def candidates_links(garde)
    garde.assignments.includes(:user).map { |assignment| link_to_remove_or_text_for_candidate(assignment) }.join(', ').html_safe if garde.assignments.any?
  end

  def link_to_remove_or_text_for_candidate(assignment)
    if can?(:destroy, assignment)
      link_to_remove_candidate(assignment)
    else
      assignment.user.name
    end
  end

  def link_to_remove_candidate(assignment)
    link_to (assignment.user_name + '&nbsp;' + content_tag(:span, nil, class: 'glyphicon glyphicon-remove')).html_safe,
      assignment_path(assignment), title: "Enlever #{assignment.user_name} de #{assignment.garde}",
      method: :delete, remote: true, class: 'btn btn-xs btn-danger'
  end

  def button_to_choose_garde(garde)
    if garde.active? and garde.can_accept_more_candidates? and garde.belongs_to_open_period? and !current_user.has_already_chosen?(garde)
      link_to content_tag(:span, nil, class: 'glyphicon glyphicon-ok'),
        assignments_path(assignment: {garde_id: garde.id, user_id: current_user.id}),
        title: "Choisir la garde - #{garde.time} - #{l(garde.date)}",
        method: :post, remote: true, class: 'btn btn-success btn-xs create-assignment'
    end
  end
end

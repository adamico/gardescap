class AssignmentsController < ApplicationController
  respond_to :js
  load_and_authorize_resource

  def create
    @assignment = Assignment.create(assignment_params)
    set_activity_params
    @assignment.create_activity :create, owner: current_user
  end

  def destroy
    set_activity_params
    @assignment.create_activity :destroy, owner: current_user
    @assignment.destroy
  end

  private

  def set_activity_params
    @assignment.activity_params ||= {garde_id: @assignment.garde.id}
  end

  def assignment_params
    params.require(:assignment).permit(:garde_id, :user_id)
  end
end

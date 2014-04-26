class Assignment < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :garde

  delegate :name, to: :user, prefix: true

  def owned_by?(auser)
    return true if auser.admin?
    user == auser
  end
end

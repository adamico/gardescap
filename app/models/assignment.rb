class Assignment < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :garde
end

class Garde < ActiveRecord::Base
  include PublicActivity::Common

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :candidates

  TIMES = ["MatinJ", "MatinS", "AMJ", "AMS", "Nuit Courte", "Nuit Longue"]

  validates :date, :time, presence: true

  belongs_to :period, touch: true
end

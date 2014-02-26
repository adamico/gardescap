class Garde < ActiveRecord::Base
  include PublicActivity::Common

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :candidates

  TIMES = {
    "jj" => ["la", "Journée/AM Junior"],
    "js" => ["la", "Journée/AM Senior"],
    "nc"  => ["la ", "Nuit Courte"],
    "nl"  => ["la ", "Nuit Longue"]
  }

  validates :date, :time, presence: true

  belongs_to :period, touch: true

  def upcase_candidate_list
    candidate_list.map(&:upcase).join(", ") if candidate_list
  end

  def candidates_count
    candidates.count
  end
end

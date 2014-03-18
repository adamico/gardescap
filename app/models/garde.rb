class Garde < ActiveRecord::Base
  include PublicActivity::Common

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :candidates

  by_star_field :date

  TIMES = {
    "jj" => "Journée/AM Junior",
    "js" => "Journée/AM Senior",
    "nc"  => "Nuit Courte",
    "nl"  => "Nuit Longue"
  }

  validates :date, :time, presence: true

  belongs_to :period, touch: true

  def self.with_time(time)
    where(time: time)
  end

  def self.am
    where(time: ["jj", "js"]).select {|g| g.date.saturday?}
  end

  def self.jj
    where(time: ["jj", "js"]).select {|g| !g.date.saturday?}
  end

  def to_s
    time_date(false)
  end

  def time_date(with_article= true)
    the_time = with_article ? ["la", garde_time].join(" ") : garde_time
    [the_time, garde_date].join(" ")
  end

  def upcase_candidate_list
    candidate_list.map(&:upcase).join(", ") if candidate_list
  end

  def candidates_count
    candidates.count
  end

  private

  def garde_date
    "du #{I18n.l date}"
  end

  def garde_time
    Garde::TIMES[time]
  end
end

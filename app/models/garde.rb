class Garde < ActiveRecord::Base
  by_star_field :date

  TIMES = {
    "jj" => "Journée/AM Junior",
    "js" => "Journée/AM Senior",
    "nc"  => "Nuit Courte",
    "nl"  => "Nuit Longue"
  }

  MAX_CANDIDATES = 3

  validates :date, :time, presence: true

  belongs_to :period, touch: true
  has_many :users, through: :assignments
  has_many :assignments, dependent: :destroy

  def belongs_to_open_period?
    period.open?
  end

  def can_accept_more_candidates?
    candidates_count < MAX_CANDIDATES
  end

  def candidate_list
    users.map(&:name)
  end

  def upcase_candidate_list
    candidate_list.map(&:upcase).join(", ") if candidate_list
  end

  def candidates_count
    users.count
  end

  def self.with_candidate(name)
    joins(:users).where(users: {name: name})
  end

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
    time_date
  end

  def time_date(with_article= true)
    the_time = with_article ? ["la", garde_time].join(" ") : garde_time
    [the_time, garde_date].join(" ")
  end

  private

  def garde_date
    "du #{I18n.l date}"
  end

  def garde_time
    Garde::TIMES[time]
  end
end

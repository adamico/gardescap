class Period < ActiveRecord::Base
  default_scope order(:ends_at)

  has_many :gardes

  def self.active
    Period.where(state: :closed)
  end

  def name
    I18n.l(starts_at).to_s + " - " + I18n.l(ends_at).to_s
  end

  def mois
    months_in_period = ((ends_at - starts_at).to_f / 30).round
    result = []
    (0..(months_in_period-1)).each do |i|
      result << (starts_at + i.months).month
    end
    result
  end

  def days(month=nil)
    if month
      range.select {|date| date.month == month}
    else
      range
    end
  end

  def create_gardes
    ActiveRecord::Base.transaction do
      days.each do |day|
        Garde::TIMES.each_key do |time|
          if time == "mj" or time == "ms"
            next unless day.sunday?
          elsif time == "amj" or time == "ams"
            next unless day.saturday? or day.sunday?
          end
          Garde.create_with(period: self).find_or_create_by(date: day, time: time)
        end
      end
    end
  end

  state_machine initial: :open do
    event :close do
      transition open: :closed
    end
  end

  private

  def range
    (starts_at..ends_at).to_a
  end
end

class Period < ActiveRecord::Base
  def self.active
    Period.where(state: :active)
  end

  def name
    I18n.l(starts_at).to_s + " - " + I18n.l(ends_at).to_s
  end

  def gardes
    Garde.where(date: starts_at..ends_at).order(:date)
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
        Garde::TIMES.each do |time|
          if time == "MatinJ" or time == "MatinS"
            next unless day.sunday?
          elsif time == "AMJ" or time == "AMS"
            next unless day.saturday? or day.sunday?
          end
          Garde.create(date: day, time: time)
        end
      end
    end
  end

  private

  def range
    (starts_at..ends_at).to_a
  end
end

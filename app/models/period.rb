class Period < ActiveRecord::Base
  default_scope {order(:ends_at)}

  has_many :gardes

  enum state: [:open, :closed]

  def self.active
    Period.open
  end

  def name
    I18n.l(starts_at).to_s + ' - ' + I18n.l(ends_at).to_s
  end

  def months_years
    result = []
    (0..(months_in_period-1)).each do |i|
      current_month = starts_at + i.months
      result << {year: current_month.year, month: current_month.month}
    end
    result
  end

  def mois
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

  def create_gardes!
    days.each do |day|
      Garde::TIMES.each_key do |time|
        garde = Garde.find_or_initialize_by(date: day, time: time)
        garde.holiday = true if day.sunday? or day.saturday?
        garde.period = self
        garde.save!
        # rendre la garde active si la plage actuelle est une journée et le jour actuel est un samedi ou un dimanche ou si la plage actuelle est une nuit (longue/courte)
        garde.active! if (%w(jj js).include?(time) and (day.saturday? || day.sunday?)) or %w(nc nl).include?(time)
      end
    end
  end

  private

  def range
    (starts_at..ends_at).to_a
  end

  def months_in_period
    ((ends_at - starts_at).to_f / 30.0).ceil
  end
end

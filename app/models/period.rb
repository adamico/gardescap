class Period < ActiveRecord::Base
  default_scope {order(:ends_at)}

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

  def create_gardes!
    gardes = []
    days.each do |day|
      Garde::TIMES.each_key do |time|
        if time == "jj" or time == "js"
          next unless day.saturday? or day.sunday?
        end
        garde = Garde.find_or_initialize_by(date: day, time: time)
        garde.period = self
        garde.save!
        gardes << garde if garde.new_record?
      end
    end
    Garde.import gardes
  end

  state_machine initial: :open do
    event :close do
      transition open: :closed
    end
    event :reopen do
      transition closed: :open
    end
  end

  private

  def range
    (starts_at..ends_at).to_a
  end
end

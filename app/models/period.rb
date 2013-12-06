class Period < ActiveRecord::Base
  def name
    I18n.l(starts_at).to_s + " - " + I18n.l(ends_at).to_s
  end

  def gardes
    Garde.where(date: starts_at..ends_at).order(:date)
  end
end

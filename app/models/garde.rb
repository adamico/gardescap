class Garde < ActiveRecord::Base
  include PublicActivity::Common

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :candidates

  TIMES = {
    "mj"  => ["le ", "Matin Junior"],
    "ms"  => ["le ", "Matin Sénior"],
    "amj" => ["l'", "Après-midi Junior"],
    "ams" => ["l'", "Après-midi Senior"],
    "nc"  => ["la ", "Nuit Courte"],
    "nl"  => ["la ", "Nuit Longue"]
  }

  validates :date, :time, presence: true

  belongs_to :period, touch: true
end

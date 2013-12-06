class Garde < ActiveRecord::Base
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :candidates
end

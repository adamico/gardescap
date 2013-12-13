require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ActivitiesHelper. For example:
#
# describe ActivitiesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ActivitiesHelper do
  describe "#candidates_changes_for" do
    it "should announce a candidates add" do
      expect(helper.candidates_changes_for(subject)).to eq "mardi 10 décembre 2013 20:24 user a rajouté user à la Nuit Longue du 01/05/2014"
    end
  end
end

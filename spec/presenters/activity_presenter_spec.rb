require 'spec_helper'
require 'activity_presenter'

describe ActivityPresenter do
  let(:user)     {create(:user)}
  let(:garde)    {create(:garde, date: "2014-05-01", time: "nuit longue", candidate_list: ["tizio", "caio"])}
  let(:activity) {garde.create_activity(:update, owner: user)}

  subject {ActivityPresenter.new(activity, view)}

  describe "attributes" do
    its(:date)       {should eq I18n.l(activity.created_at, format: :long)}
    its(:garde_date) {should match /#{I18n.l(garde.date)}/}
    its(:garde_time) {should match /#{garde.time}/}
  end

  describe "#candidates_changes_for" do
    describe "candidate list changes" do
      subject {ActivityPresenter.new(activity, view)}

      it "should print a 'candidate added' kind of message when a candidate is added" do
        garde.activity_params = {old_candidates: garde.candidate_list, new_candidates: ["tizio", "caio", "sempronio"]}
        garde.update_attribute(:candidate_list, ["sempronio"])
        expect(subject.candidates_changes_for).to match "a rajouté sempronio"
      end

      it "should print a 'candidate removed' kind of message when a candidate is removed" do
        garde.activity_params = {old_candidates: garde.candidate_list, new_candidates: ["tizio"]}
        garde.update_attribute(:candidate_list, ["tizio"])
        expect(subject.candidates_changes_for).to match "a enlevé caio"
      end

      it "should warn that the candidate list is empty when all candidates are removed" do
        garde.activity_params = {old_candidates: garde.candidate_list, new_candidates: []}
        garde.update_attribute(:candidate_list, [])
        expect(subject.candidates_changes_for).to match "a enlevé tizio, caio"
        expect(subject.candidates_changes_for).to match "(Nouvelle liste : aucun candidat)"
      end
    end
  end
end

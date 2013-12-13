require 'spec_helper'
require 'activity_presenter'

describe ActivityPresenter do
  let(:user)     {create(:user)}
  let(:garde)    {create(:garde, date: "2014-05-01", time: "nl", candidate_list: [])}
  let(:activity) {garde.create_activity(:update, owner: user)}

  subject {ActivityPresenter.new(activity, view)}

  describe "attributes" do
    its(:date)       {should match /#{I18n.l(activity.created_at, format: :long)}/}
    its(:owner)      {should match /#{user.to_s}/}
    its(:garde_date) {should match /#{I18n.l(garde.date)}/}
    its(:garde_time) {should match /la Nuit Longue/}
  end

  describe "#candidate_changes" do
    context "when a candidate is added" do
      let(:old_list) { ["tizio", "caio"] }
      let(:new_list) { ["tizio", "caio", "sempronio"] }
      let(:garde)    { create(:garde, date: "2014-05-01", time: "nl", candidate_list: old_list) }
      let(:activity) { garde.create_activity(:update, owner: user) }

      before do
        garde.activity_params = {old_candidates: old_list, new_candidates: new_list}
        garde.update_attribute(:candidate_list, new_list)
      end

      it "should print a 'candidate added' kind of message" do
        expect(ActivityPresenter.new(activity, view).candidates_message).to match /a rajouté/
      end

      it "should print the added candidate" do
        expect(ActivityPresenter.new(activity, view).candidates_list).to match /SEMPRONIO/
      end

      it "should print the updated list" do
        expect(ActionView::Base.full_sanitizer.sanitize(ActivityPresenter.new(activity, view).nouvelle_liste)).to match /Nouvelle liste : TIZIO&nbsp;CAIO&nbsp;SEMPRONIO/
      end
    end

    context "when a candidate is removed" do
      let(:old_list) { ["tizio", "caio", "sempronio"] }
      let(:new_list) { ["tizio", "caio"] }
      let(:garde)    { create(:garde, date: "2014-05-01", time: "nl", candidate_list: old_list) }
      let(:activity) { garde.create_activity(:update, owner: user) }

      before do
        garde.activity_params = {old_candidates: old_list, new_candidates: new_list}
        garde.update_attribute(:candidate_list, new_list)
      end

      it "should print a 'candidate removed' kind of message" do
        expect(ActivityPresenter.new(activity, view).candidates_message).to match /a enlevé/
      end

      it "should print the removed candidate" do
        expect(ActivityPresenter.new(activity, view).candidates_list).to match /SEMPRONIO/
      end

      it "should print the updated list" do
        expect(ActionView::Base.full_sanitizer.sanitize(ActivityPresenter.new(activity, view).nouvelle_liste)).to match /Nouvelle liste : TIZIO&nbsp;CAIO/
      end
    end

    it "should warn that the candidate list is empty when all candidates are removed" do
      old_list = ["tizio", "caio", "sempronio"]
      new_list =  []
      lagarde = create(:garde, date: "2014-05-01", time: "nl", candidate_list: old_list)
      lagarde.activity_params = {old_candidates: old_list, new_candidates: new_list}
      lagarde.update_attribute(:candidate_list, new_list)
      activity = lagarde.create_activity(:update, owner: user)
      expect(ActivityPresenter.new(activity, view).render_activity_update).to match /aucun candidat/
    end
  end
end

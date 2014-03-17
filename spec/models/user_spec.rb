require "spec_helper"
require "cancan/matchers"

describe User do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { build_stubbed(:user) }
    let(:other_user) { build_stubbed(:user) }
    let(:garde)  { build_stubbed(:garde, period: period)}
    let(:own_assignment) { build_stubbed(:assignment, user: user, garde: garde)}
    let(:other_assignment) { build_stubbed(:assignment, user: other_user, garde: garde)}

    it {is_expected.to be_able_to(:read, Garde.new)}
    it {is_expected.to be_able_to(:index, :home)}
    it {is_expected.to be_able_to(:stats, :home)}
    context "when period is open" do
      let(:period) { build_stubbed(:period) }
      it {is_expected.to be_able_to(:create, Assignment.new)}
      it {is_expected.to be_able_to(:destroy, own_assignment)}
      it {is_expected.not_to be_able_to(:destroy, other_assignment)}
    end
    context "when period is closed" do
      let(:period) { create(:period, state: "closed") }
      it {is_expected.not_to be_able_to(:create, Assignment.new(garde: garde, user: user))}
      it {is_expected.not_to be_able_to(:destroy, own_assignment)}
    end
    context "when user is admin" do
      let(:user) {build_stubbed(:admin)}
      let(:period) { build_stubbed(:period, state: "closed") }
      let(:garde)  { build_stubbed(:garde, period: period)}
      it {is_expected.not_to be_able_to(:destroy, user)}
    end
  end
end

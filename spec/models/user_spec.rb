require "spec_helper"
require "cancan/matchers"

describe User do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { build_stubbed(:user) }

    it {is_expected.to be_able_to(:read, Garde.new)}
    it {is_expected.to be_able_to(:index, :home)}
    it {is_expected.to be_able_to(:stats, :home)}
    it {is_expected.to be_able_to(:tags, Garde)}
    context "when period is open" do
      let(:period) { build_stubbed(:period) }
      let(:garde)  { build_stubbed(:garde, period: period)}
      it {is_expected.to be_able_to(:update, garde)}
    end
    context "when period is closed" do
      let(:period) { build_stubbed(:period, state: "closed") }
      let(:garde)  { build_stubbed(:garde, period: period)}
      it {is_expected.not_to be_able_to(:update, garde)}
    end
    context "when user is admin" do
      let(:user) {build_stubbed(:admin)}
      let(:period) { build_stubbed(:period, state: "closed") }
      let(:garde)  { build_stubbed(:garde, period: period)}
      it {is_expected.not_to be_able_to(:destroy, user)}
    end
  end
end

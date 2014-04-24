require 'spec_helper'
require 'cancan/matchers'

describe User do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { build_stubbed(:user) }
    let(:other_user) { build_stubbed(:user) }
    let(:period) { build_stubbed(:period) }
    let(:garde)  { build_stubbed(:garde, period: period)}
    let(:own_assignment) { build_stubbed(:assignment, user: user, garde: garde)}
    let(:other_assignment) { build_stubbed(:assignment, user: other_user, garde: garde)}

    it {expect(subject).to be_able_to(:read, Garde.new)}
    it {expect(subject).to be_able_to(:index, :home)}
    it {expect(subject).to be_able_to(:stats, :home)}
    it {expect(subject).to be_able_to(:create, Assignment.new)}
    it {expect(subject).to be_able_to(:destroy, own_assignment)}
    it {expect(subject).not_to be_able_to(:destroy, other_assignment)}

    context 'when user is admin' do
      let(:user) {build_stubbed(:admin)}
      let(:period) { build_stubbed(:period, state: 'closed') }
      let(:garde)  { build_stubbed(:garde, period: period)}
      it {expect(subject).not_to be_able_to(:destroy, user)}
    end
  end
end

require 'spec_helper'
require 'activity_presenter'

describe ActivityPresenter do
  let(:user)       { create(:user) }
  let(:garde)      { create(:garde, date: '2014-05-01', time: 'nl') }
  let(:assignment) { create(:assignment, garde: garde, user: user) }

  describe '#render_activity_update' do
    context 'for assignment creation' do
      let(:activity)   { assignment.create_activity(:create, owner: user) }
      subject { ActivityPresenter.new(activity, view) }

      it 'exists' do
        expect(subject).to respond_to(:render_activity_update)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe SleepTracker, type: :model do
  let(:user) { FactoryGirl.create :user, name: 'Mark' }
  let!(:sleep_record) { FactoryGirl.create :sleeping_record, user: user }

  describe '.check_in' do
    context 'when user is awake' do
      it 'successfully checks in' do
        expect { SleepTracker.check_in(user) }.
          to change { user.sleeping_records.reload.count }.from(1).to(2)
      end
    end

    context 'when user is already sleeping' do
      before do
        sleep_record.update!(check_out_time: nil)
      end
      it 'returns nil' do
        expect { SleepTracker.check_in(user) }.
            to_not change { user.sleeping_records.reload.count }
      end
    end
  end

  describe '.check_out' do
    context 'when user is awake' do
      it 'returns nil' do
        expect { SleepTracker.check_out(user) }.
            to_not change { user.sleeping_records.reload.count }
      end
    end

    context 'when user is sleeping' do
      before do
        sleep_record.update!(check_out_time: nil)
      end
      it 'successfully checks out' do
        expect { SleepTracker.check_out(user) }.
            to change { sleep_record.reload.check_out_time }
      end
    end
  end
end

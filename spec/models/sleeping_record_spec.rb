require 'rails_helper'

RSpec.describe SleepingRecord, type: :model do
  let(:record) { FactoryGirl.create :sleeping_record }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :check_in_time }

  describe 'uniqueness of date' do
    let(:invalid_record) do
      FactoryGirl.build :sleeping_record,
                        user: record.user,
                        date: record.date,
                        check_in_time: record.check_in_time
    end
    let(:another_valid_record) do
      FactoryGirl.build :sleeping_record, user: record.user,
                        check_in_time: record.check_in_time + 1.day,
                        check_out_time: record.check_out_time + 1.day,
                        date: record.check_in_time.to_date + 1
    end

    before do
      record
    end

    it 'validates scoped by user and check in time' do
      expect(invalid_record.valid?).to eq(false)
      expect(another_valid_record.valid?).to eq(true)
    end
  end

  describe 'scopes' do
    let(:first_user) { FactoryGirl.create :user }
    let(:second_user) { FactoryGirl.create :user }
    let!(:first_user_sleep) { FactoryGirl.create :sleeping_record, user: first_user }
    let!(:second_user_sleep) { FactoryGirl.create :sleeping_record, user: second_user }

    context '.weekly' do
      it 'returns all records of past week' do
        expect(SleepingRecord.weekly).to match_array([first_user_sleep, second_user_sleep])
      end
    end
  end

  describe '#total_slept' do
    let(:user) { FactoryGirl.create :user }
    let(:user_sleep) do
      FactoryGirl.create :sleeping_record,
                         user: user,
                         check_in_time: DateTime.now,
                         check_out_time: DateTime.now + 2.hours,
                         date: Date.today
    end

    it 'returns the total time slept from a record' do
      expect(user_sleep.total_slept).to eq('02:00:00')
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create :user, name: 'Mark' }
  let(:sleeping_record) { FactoryGirl.create :sleeping_record, user: user }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :sleeping_records }
  it { is_expected.to have_and_belong_to_many :followers }
  it { is_expected.to have_and_belong_to_many :following }

  describe 'uniqueness of name' do
    let(:invalid_user) { FactoryGirl.build :user, name: 'Mark' }
    let(:another_valid_user) { FactoryGirl.build :user }

    it 'validates the uniqueness of the names' do
      user
      expect(invalid_user.valid?).to eq(false)
      expect(another_valid_user.valid?).to eq(true)
    end
  end

  describe '#is_sleeping?' do
    before do
      sleeping_record
    end

    it 'returns true if latest check out not present' do
      expect(user.is_sleeping?).to eq(false)
    end
  end

  describe '#is_awake?' do
    before do
      sleeping_record
    end

    it 'returns true if latest check out is present' do
      expect(user.is_awake?).to eq(true)
    end
  end

  describe '#friends' do
    let(:another_user) { FactoryGirl.create :user, name: 'Junan' }

    before do
      user.following << another_user
    end

    context 'when they are not friends' do
      it 'returns a list that will not have another user' do
        expect(user.friends).to eq([])
      end
    end

    context 'when they are friends' do
      before do
        another_user.following << user
      end

      it 'returns a list that will not have another user' do
        expect(user.friends).to eq([another_user])
      end
    end
  end
end

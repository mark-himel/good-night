require 'rails_helper'

RSpec.describe API::V1::Entities::SleepingRecord do
  let(:user) { FactoryGirl.create(:user, name: 'Mark') }
  let!(:sleeping_record) { FactoryGirl.create(:sleeping_record, user: user) }
  let(:sleeping_entity) { API::V1::Entities::SleepingRecord.represent(sleeping_record) }
  subject { JSON.parse(sleeping_entity.to_json) }

  it 'matches the api specification' do
    expect(subject).to be_a(Hash)
  end
end

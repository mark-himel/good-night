require 'rails_helper'

RSpec.describe API::V1::Entities::Friend do
  let!(:user) { FactoryGirl.create(:user, name: 'Mark') }
  let(:friend_entity) { API::V1::Entities::Friend.represent(user) }
  subject { JSON.parse(friend_entity.to_json) }
  let(:expected_hash) do
    {
        'id' => user.id,
        'name' => 'Mark',
        'weekly_sleeping_records' => [],
    }
  end

  it 'matches the api specification' do
    expect(subject).to eq expected_hash
  end
end

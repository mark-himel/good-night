require 'rails_helper'

RSpec.describe API::V1::Entities::Follower do
  let!(:user) { FactoryGirl.create(:user, name: 'Mark') }
  let(:follower_entity) { API::V1::Entities::Follower.represent(user) }
  subject { JSON.parse(follower_entity.to_json) }
  let(:expected_hash) do
    {
      'id' => user.id,
      'name' => 'Mark',
    }
  end

  it 'matches the api specification' do
    expect(subject).to eq expected_hash
  end
end

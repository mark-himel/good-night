require 'rails_helper'

RSpec.describe API::V1::Entities::User do
  let!(:user) { FactoryGirl.create(:user, name: 'Mark') }
  let(:user_entity) { API::V1::Entities::User.represent(user) }
  subject { JSON.parse(user_entity.to_json) }
  let(:expected_hash) do
    {
        'id' => user.id,
        'name' => 'Mark',
        'followers' => [],
        'following' => [],
    }
  end

  it 'matches the api specification' do
    expect(subject).to eq expected_hash
  end
end

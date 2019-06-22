require 'rails_helper'

RSpec.describe API::V1::Resources::Users do
  let!(:user) { FactoryGirl.create(:user) }
  let(:request_url) { "/api/users/#{user.id}" }
  let(:response_json) { JSON.parse(response.body) }
  let(:user_entity) { API::V1::Entities::User.represent(user) }

  describe 'Get /users/:id' do
    it 'returns a hash of user profile' do
      get request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(200)
      expect(response_json).to eq(JSON.parse(user_entity.to_json))
    end
  end
end

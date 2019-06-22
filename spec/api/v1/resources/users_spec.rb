require 'rails_helper'

RSpec.describe API::V1::Resources::Users do
  let!(:user) { FactoryGirl.create(:user) }
  let(:request_url) { "/api/users/#{user.id}" }
  let(:response_json) { JSON.parse(response.body) }
  let(:user_entity) { API::V1::Entities::User.represent(user) }

  describe 'GET /users/:id' do
    it 'returns a hash of user profile' do
      get request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(200)
      expect(response_json).to eq(JSON.parse(user_entity.to_json))
    end
  end

  describe 'POST /users' do
    let(:request_url) { "/api/users?name=John Wick" }
    let(:user_entity) { API::V1::Entities::User.represent(User.last) }

    it 'creates a new user' do
      post request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(201)
      expect(response_json).to eq(JSON.parse(user_entity.to_json))
    end
  end

  describe 'POST /users/:id/check_in' do
    let(:request_url) { "/api/users/#{user.id}/check_in" }
    let(:sleep_entity) { API::V1::Entities::SleepingRecord.represent(SleepingRecord.last) }

    it 'creates a new sleep record for the user' do
      post request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(201)
      expect(response_json).to eq(JSON.parse(sleep_entity.to_json))
    end
  end

  describe 'POST /users/:id/check_out' do
    let(:request_url) { "/api/users/#{user.id}/check_out" }
    let(:sleep_entity) { API::V1::Entities::SleepingRecord.represent(SleepingRecord.last) }

    it 'updates the latest sleep record for the user to have the check out' do
      post request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(201)
      expect(response_json).to eq(JSON.parse(sleep_entity.to_json))
    end
  end

  describe 'POST /users/:id/follow?followed_user_id=:followed_id' do
    let(:another_user) { FactoryGirl.create :user, name: 'John Wick'}
    let(:request_url) { "/api/users/#{user.id}/follow?followed_user_id=#{another_user.id}" }
    let(:user_entity) { API::V1::Entities::User.represent(user) }

    it 'updates the user to have the follower' do
      post request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(201)
      expect(response_json).to eq(JSON.parse(user_entity.to_json))
    end
  end

  describe 'POST /users/:id/unfollow?followed_user_id=:followed_id' do
    let(:another_user) { FactoryGirl.create :user, name: 'John Wick'}
    let(:request_url) { "/api/users/#{user.id}/unfollow?followed_user_id=#{another_user.id}" }
    let(:user_entity) { API::V1::Entities::User.represent(user) }

    before do
      user.followers << another_user
    end

    it 'removes the follower from the user follower list' do
      post request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(201)
      expect(response_json).to eq(JSON.parse(user_entity.to_json))
    end
  end

  describe 'GET /users/:id/friends' do
    let(:another_user) { FactoryGirl.create :user, name: 'John Wick'}
    let(:request_url) { "/api/users/#{user.id}/friends" }
    let(:friends_entity) { API::V1::Entities::Friend.represent(user.friends) }

    before do
      user.followers << another_user
      another_user.followers << user
    end

    it 'removes the follower from the user follower list' do
      get request_url
      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(200)
      expect(response_json).to eq(JSON.parse(friends_entity.to_json))
    end
  end
end

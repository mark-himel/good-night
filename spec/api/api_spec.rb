require 'rails_helper'

RSpec.describe API do
  let!(:user) { FactoryGirl.create(:user) }
  let(:wrong_endpoint) { '/api/wrong_endpoint' }

  it 'returns 404 on invalid endpoint' do
    get wrong_endpoint
    expect(response.status).to eq 404
  end
end

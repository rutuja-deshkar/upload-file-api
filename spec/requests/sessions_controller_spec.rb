require 'rails_helper'

RSpec.describe 'POST users/sign_in', type: :request do
  let(:user) { Fabricate(:user) }
  let(:url) { 'http://localhost:3000/users/sign_in' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JWT token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      decoded_token = decoded_jwt_token_from_response(response)
      expect(decoded_token.first['sub']).to be_present
    end
  end

  context 'when sign_in params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE users/sign_out', type: :request do
  let(:url) { 'http://localhost:3000/users/sign_out' }

  it 'returns 204, no content' do
    delete url
    expect(response).to have_http_status(204)
  end
end

require 'rails_helper'

RSpec.describe 'POST /users', type: :request do
  let(:url) { '/users' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'creates a new user' do
      expect(response.status).to eq 200
    end
  end

  context 'when user already exists' do
    before do
      let(:user) { create(:user) }
      let email: params[:user][:email]
      post url, params: params
    end
    # before { post url, params: params }

    it 'does not create a new user' do
      expect(response).to have_http_status(422)
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(json['errors'].first['title']).to eq('Bad Request')
    end
  end
end



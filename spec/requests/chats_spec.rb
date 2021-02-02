require 'rails_helper'

RSpec.describe 'Chats API' do
  let!(:application) { create(:application) }
  let!(:chats) { create_list(:chat, 20, application_id: application.id) }
  let(:application_token) { application.token }
  let(:number) { chats.first.number }

  # Test suite for GET /api/v1/applications/:application_token/chats
  describe 'GET /api/v1/applications/:application_token/chats' do
    before { get "/api/v1/applications/#{application_token}/chats" }

    context 'when chat exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all application chats' do
        expect(json.size).to eq(20)
      end
    end

    context 'when application does not exist' do
      let(:application_token) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Application/)
      end
    end
  end

  # Test suite for GET /api/v1/applications/:application_token/chats/:number
  describe 'GET /api/v1/applications/:application_token/chats/:number' do
    before { get "/api/v1/applications/#{application_token}/chats/#{number}" }

    context 'when application chat exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the chat' do
        expect(json['number']).to eq(number)
      end
    end

    context 'when application chat does not exist' do
      let(:number) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Chat/)
      end
    end
  end

  # Test suite for DELETE /api/v1/applications/:application_token/chats/chats/:number
  describe 'DELETE /api/v1/applications/:application_token/chats/:number' do
    before { delete "/api/v1/applications/#{application_token}/chats/#{number}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
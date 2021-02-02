require 'rails_helper'

RSpec.describe 'Messages API' do
  let!(:application) { create(:application) }
  let!(:chat) { create(:chat, application_id: application.id) }
  let!(:messages) { create_list(:message, 20, chat_id: chat.id) }
  let(:application_token) { application.token }
  let(:chat_number) { chat.number }
  let(:number) { messages.first.number }

  # Test suite for GET /api/v1/applications/:application_token/chats/:chat_number/messages
  describe 'GET /api/v1/applications/:application_token/chats/:chat_number/messages' do
    before { get "/api/v1/applications/#{application_token}/chats/#{chat_number}/messages" }

    context 'when message exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all chats messages' do
        expect(json.size).to eq(20)
      end
    end

    context 'when chat does not exist' do
      let(:chat_number) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Chat/)
      end
    end
  end

  # Test suite for GET /api/v1/applications/:application_token/chats/:chat_number/messages/:number
  describe 'GET /api/v1/applications/:application_token/chats/:chat_number/messages/:number' do
    before { get "/api/v1/applications/#{application_token}/chats/#{chat_number}/messages/#{number}" }

    context 'when chat message exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the message' do
        expect(json['number']).to eq(number)
      end
    end

    context 'when chat message does not exist' do
      let(:number) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  # Test suite for DELETE /api/v1/applications/:application_token
  describe 'DELETE /api/v1/applications/:application_token/chats/:chat_number/messages/:number' do
    before { delete "/api/v1/applications/#{application_token}/chats/#{chat_number}/messages/#{number}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
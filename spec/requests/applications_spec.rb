require 'rails_helper'

RSpec.describe 'Applications API', type: :request do
  let!(:applications) { create_list(:application, 10) }
  let(:application_token) { applications.first.token }

  # Test suite for GET /api/v1/applications
  describe 'GET /api/v1/applications' do
    before { get '/api/v1/applications' }

    it 'returns applications' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/applications/:token
  describe 'GET /api/v1/applications/:token' do
    before { get "/api/v1/applications/#{application_token}" }

    context 'when the record exists' do
      it 'returns the application' do
        expect(json).not_to be_empty
        expect(json['token']).to eq(application_token)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:application_token) { '2ctkwUwo15RqFY5Z6WQu4' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Application/)
      end
    end
  end

  # Test suite for POST /api/v1/applications
  describe 'POST /api/v1/apllications' do
    let(:valid_attributes) { { name: 'Instabug' } }

    context 'when the request is valid' do
      before { post '/api/v1/applications', params: valid_attributes }

      it 'creates an application' do
        expect(json['name']).to eq('Instabug')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/applications', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for DELETE /appplications/:token
  describe 'DELETE /api/v1/applications/:token' do
    before { delete "/api/v1/applications/#{application_token}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
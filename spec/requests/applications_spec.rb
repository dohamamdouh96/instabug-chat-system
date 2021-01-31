require 'rails_helper'

RSpec.describe 'Applications API', type: :request do
  let!(:applications) { create_list(:application, 10) }
  let(:application_token) { applications.first.token }

  # Test suite for GET /applications
  describe 'GET /applications' do
    before { get '/applications' }

    it 'returns applications' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /applications/:token
  describe 'GET /applications/:token' do
    before { get "/applications/#{application_token}" }

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

  # Test suite for POST /applications
  describe 'POST /apllications' do
    let(:valid_attributes) { { name: 'Instabug' } }

    context 'when the request is valid' do
      before { post '/applications', params: valid_attributes }

      it 'creates an application' do
        expect(json['name']).to eq('Instabug')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/applications', params: { name: '' } }

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
  describe 'DELETE /applications/:token' do
    before { delete "/applications/#{application_token}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
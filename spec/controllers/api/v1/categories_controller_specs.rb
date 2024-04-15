# spec/controllers/api/v1/categories_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'Test Category' } }

      it 'creates a new category' do
        expect {
          post :create, params: valid_params
        }.to change(Category, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { name: nil } }

      it 'does not create a new category' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Category, :count)
      end

      it 'returns an unprocessable_entity response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post :create, params: invalid_params
        expect(JSON.parse(response.body)['status']).to eq('error')
      end
    end
  end
end

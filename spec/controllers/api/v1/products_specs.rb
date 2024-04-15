require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET #index' do
    it 'returns a list of products' do
      products = FactoryBot.create_list(:product, 3)
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to match_array(products.as_json)
    end
  end

  describe 'GET #show' do
    context 'when the product exists' do
      it 'returns the product' do
        product = FactoryBot.create(:product)
        get :show, params: { id: product.id }
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to eq(product.as_json)
      end
    end

    context 'when the product does not exist' do
      it 'returns not found' do
        get :show, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new product' do
        category = FactoryBot.create(:category)
        product_params = FactoryBot.attributes_for(:product, category_id: category.id)
        post :create, params: product_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('product')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new product' do
        post :create, params: { name: '', price: 10 }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('error')
      end
    end
  end
end
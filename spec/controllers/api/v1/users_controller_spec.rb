require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #index' do
  it 'returns a success response' do
    get :index
    expect(response).to be_successful
  end
end
describe 'POST #create' do
  context 'with valid parameters' do
    it 'creates a new user' do
      expect {
        post :create, params: { name: 'John', username: 'john_doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' }
      }.to change(User, :count).by(1)
    end
    it 'returns a created status' do
      post :create, params: { name: 'John', username: 'john_doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' }
      expect(response).to have_http_status(:created)
    end
  end
  context 'with invalid parameters' do
    it 'returns an unprocessable entity status' do
      post :create, params: { name: 'John', username: 'john_doe', email: 'invalid_email', password: 'password', password_confirmation: 'password' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
end
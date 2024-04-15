# spec/controllers/api/v1/posts_controller_spec.rb
require 'rails_helper'
RSpec.describe Api::V1::PostsController, type: :controller do
  describe 'GET #index' do
    it 'returns a list of posts' do
      posts = FactoryBot.create_list(:post, 3)
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq(posts.as_json)
    end
  end
  describe 'GET #show' do
    it 'returns the specified post' do
      post = FactoryBot.create(:post)
      get :show, params: { id: post.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq(post.as_json)
    end
  end
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new post' do
        post_params = FactoryBot.attributes_for(:post)
        post_count_before = Post.count
        post :create, params: post_params
        expect(response).to have_http_status(:created)
        expect(Post.count).to eq(post_count_before + 1)
      end
    end
    context 'with invalid parameters' do
      it 'does not create a new post' do
        invalid_post_params = { title: nil, description: nil }
        post_count_before = Post.count
        post :create, params: invalid_post_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Post.count).to eq(post_count_before)
      end
    end
  end
end
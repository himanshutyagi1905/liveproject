require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'image attachment' do
    it 'is valid' do
      post = FactoryBot.create(:post_with_image)
      expect(post.image).to be_attached
    end
  end
end
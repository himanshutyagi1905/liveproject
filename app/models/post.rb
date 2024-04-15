# app/models/post.rb
class Post < ApplicationRecord
    has_one_attached :image
    # Assuming you have validations for presence of image, title, and description
    validates :title, :description, presence: true 
end






  
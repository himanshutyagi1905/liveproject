
class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show]
  def index
    @posts = Post.all
    render json: @posts
  end
  def show
    render json: @post
  end
  def create
    @post = Post.new(post_params)
    @post.image = params[:image]
    if @post.save
      @image_url = url_for(@post.image) if @post.image.attached?
      render json: { post: @post, image_url: @image_url }, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end
  private
  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end
  def post_params
    params.permit(:title, :description)
  end
end

class Api::V1::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: { status: 'success', message: 'Category created successfully' }, status: :created
    else
      render json: { status: 'error', message: 'Failed to create category', errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.permit(:name)
  end
end

		class Api::V1::ProductsController < ApplicationController
		skip_before_action :verify_authenticity_token

		def index
			products = Product.all
			render json: products, each_serializer: ProductSerializer, status: :ok
		end
		def show
			product = Product.find_by(id: params[:id])
			if product
			render json: product, serializer: ProductSerializer, status: :ok
			else
			render json: { error: 'Product not found' }, status: :not_found
			end
		end
			def create
				@category = Category.find_by(id: params[:category_id])
				if @category.present?
					@product = Product.new(products_params)
					@product.image.attach(params[:image]) if params[:image]
					if @product.save
						@image_url = url_for(@product.image) if @product.image.attached?
						render json: { product: ProductSerializer.new(@product) }, status: :created
					else
						render json: { error: @product.errors.full_messages.join(', ') }, status: :unprocessable_entity
					end
				else
					render json: { message: "Category must exist" }, status: :not_found
				end
			end
			private
			def products_params
				params.permit(:name, :price, :category_id)
			end
		end
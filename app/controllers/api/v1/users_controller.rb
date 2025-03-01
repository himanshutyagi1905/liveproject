class Api::V1::UsersController < ApplicationController
  #before_action :authorize_request, except: :create
    #before_action :find_user, except: %i[create index]
   # GET /users
   #skip_before_action :verify_authenticity_token, only: :create
   def index
     @users = User.all
     render json: @users, status: :ok
   end
   # POST /users
   def create
     @user = User.new(user_params)
     if @user.save
       render json: @user, status: :created
     else
       render json: { errors: @user.errors.full_messages },
              status: :unprocessable_entity
     end
   end
   private
   def find_user
     @user = User.find_by_username!(params[:_username])
     rescue ActiveRecord::RecordNotFound
       render json: { errors: 'User not found' }, status: :not_found
   end
   def user_params
     params.permit(
        :name, :username, :email, :password, :password_confirmation
     )
   end
end


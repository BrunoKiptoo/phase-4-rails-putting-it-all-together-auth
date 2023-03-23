# class SessionsController < ApplicationController
#     def create 
#         user = User.find_by(username: params[:username])
#         if user && user.authenticate(params[:password])
#             session[:user_id] = user.id
#             render json: user, status: :created
#         else
#             render json: {error: 'Invalid username or password'}, status: :unauthorized
#         end
#     end

#     def destroy
#         if session[:user_id]
#           session.delete :user_id
#           head :no_content
#         else
#           render json: { errors: ["You must be logged in to perform this action"] }, status: :unauthorized
#         end
#       end
# end

class SessionsController < ApplicationController

    def create
        # responds to POST login request
        user = User.find_by(username: params[:username]);
        # checks if user exists and is authenticated
        if user&.authenticate(params[:password])
            # creates a new session saving user id as session id
            session[:user_id] = user.id 
            render json: user, status: :created
        else
            render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end

    def destroy
        # responds LOGOUT request
        user = User.find_by(id: session[:user_id])
        if user
            session.delete :user_id
        head :no_content
        else
            render json: {errors: ["Not authorized"]}, status: :unauthorized
        end
    end
end
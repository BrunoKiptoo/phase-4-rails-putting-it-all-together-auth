# class RecipesController < ApplicationController
#     def index
#       if session[:user_id]
#         recipes = Recipe.all.includes(:user)
#         render json: recipes.as_json(include: { user: { only: [:id, :username, :image_url, :bio] } }, only: [:title, :instructions, :minutes_to_complete]), status: :ok
#       else
#         render json: { errors: ["You need to log in to view recipes"] }, status: :unauthorized
#       end
#     end

    # def create
    #     if session[:user_id]
    #       user = User.find(session[:user_id])
    #       recipe = user.recipes.build(recipe_params)
    #       if recipe.save
    #         render json: recipe, include: [:user], status: :created
    #       else
    #         render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
    #       end
    #     else
    #       render json: { error: 'You must be logged in to create a recipe' }, status: :unauthorized
    #     end
    #   end
      
#       private
      
# def recipe_params
#   params.require(:recipe).permit(:title, :instructions, :minutes_to_complete, :user_id)
# end
#   end
  
class RecipesController < ApplicationController

    before_action :authorize

    # def index
    #     user = User.find_by(id: session[:user_id])
    #     recipes = Recipe.all
    #     render json: recipes, status: :created
    # end
    def index
              if session[:user_id]
                recipes = Recipe.all.includes(:user)
                render json: recipes.as_json(include: { user: { only: [:id, :username, :image_url, :bio] } }, only: [:title, :instructions, :minutes_to_complete]), status: :ok
              else
                render json: { errors: ["You need to log in to view recipes"] }, status: :unauthorized
              end
            end

    def create
        @user = User.find_by(id: session[:user_id])
        recipe = Recipe.create(recipe_params.merge(user_id: @user.id));
        

        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: {errors: recipe.errors.full_messages} , status: :unprocessable_entity
        end
    end

    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
    def authorize
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
    end
end
Rails.application.routes.draw do
  # POST /signup
  post '/signup', to:'users#create'

  # POST /login
  post '/login', to:'sessions#create'

  # GET /me
  get '/me', to:'users#show'

  # DELETE /logout
  delete '/logout', to:'sessions#destroy'

  # GET /recipes
  get '/recipes', to:'recipes#index'

  # POST /recipes
  post '/recipes', to:'recipes#create'
end

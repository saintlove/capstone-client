Rails.application.routes.draw do
  # STEP 1: A ROUTE triggers a controller action
  # verb "/urls" => "namespace/controllers#action"
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

   get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  namespace :client do
    #Problems Controller
    get '/problems' => 'problems#index'
    get '/problems/new' => 'problems#new'
    post '/problems' => 'problems#create'
    get '/problems/:id' => 'problems#show'
    get '/problems/:id/edit' => 'problems#edit'
    patch '/problems/:id' => 'problems#update'
    delete '/problems/:id' => 'problems#destroy'
    #  Scores Controller
       get '/scores' => 'scores#index'
    get '/scores/new' => 'scores#new'
    post '/scores' => 'scores#create'
    get '/scores/:id' => 'scores#show'
    get '/scores/:id/edit' => 'scores#edit'
    patch '/scores/:id' => 'scores#update'
    delete '/scores/:id' => 'scores#destroy'

  end
end
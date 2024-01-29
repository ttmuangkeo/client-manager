# config/routes.rb

Rails.application.routes.draw do
  # Your API routes go here...

  # Authentication route
  post '/authenticate', to: 'brytecore_auth#authenticate'
  #company route
  get '/companies/:id', to: 'brytecore_companies#show'

  get '/apikeys/:id', to: 'brytecore_companies#api_keys'
  post '/moxi/company', to: 'moxi_auth#authenticate'
  # This catch-all route will redirect all other requests to the Vue.js app
  get '*path', to: 'application#index', via: :all
end

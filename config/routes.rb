# config/routes.rb

Rails.application.routes.draw do
  # Your API routes go here...

  # brytecore routes
  post '/authenticate', to: 'brytecore_auth#authenticate'
  get '/companies/:id', to: 'brytecore_companies#show'
  get '/apikeys/:id', to: 'brytecore_companies#api_keys'

  #moxi routes
  # get '/moxi/companies', to: 'moxi_auth#index'
  get '/moxi/companies', to: 'moxi_auth#authenticate'

  get '/moxi/companies', to: 'moxi_auth#show'
  # This catch-all route will redirect all other requests to the Vue.js app
  get '*path', to: 'application#index', via: :all
end

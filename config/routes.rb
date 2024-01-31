# config/routes.rb

Rails.application.routes.draw do
  get 'moxi_branding/fetch_branding_data'
  # Your API routes go here...

  # brytecore routes
  post '/authenticate', to: 'brytecore_auth#authenticate'
  get '/companies/:id', to: 'brytecore_companies#show'
  get '/apikeys/:id', to: 'brytecore_companies#api_keys'

  #moxi routes
  post '/moxi/authenticate', to: 'moxi_auth#authenticate'
  get '/moxi/companies', to: 'moxi_auth#show'
  get '/moxi/company/branding/:moxi_works_company_id', to: 'moxi_branding#fetch_branding_data'

  delete '/logout', to: 'moxi_auth#logout'
  # This catch-all route will redirect all other requests to the Vue.js app
  get '*path', to: 'application#index', via: :all
end

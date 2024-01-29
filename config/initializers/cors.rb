# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:8080'  # Adjust the origin to match your Vue.js development server
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :delete, :options],
        credentials: true
    end
  end
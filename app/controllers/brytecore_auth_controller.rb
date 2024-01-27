# app/controllers/brytecore_auth_controller.rb

class BrytecoreAuthController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :authenticate

    def authenticate
        username = ENV['BRYTECORE_USERNAME']
        password = ENV['BRYTECORE_PASSWORD']
  
      if valid_credentials?(username, password)
        access_token = fetch_access_token(username, password)
        render json: { access_token: access_token }
      else
        render json: { error: 'Invalid credentialsss' }, status: :unauthorized
      end
    end
  
    private
  
    def valid_credentials?(username, password)
        expected_username = ENV['BRYTECORE_USERNAME']
        expected_password = ENV['BRYTECORE_PASSWORD']
    
        username == expected_username && password == expected_password
    end
  
    def fetch_access_token(username, password)
      response = RestClient.post(
        'https://auth.brytecore.com/oauth/token',
        {
          grant_type: 'client_credentials',
          scope: '*'
        },
        {
          Authorization: "Basic #{Base64.strict_encode64("#{username}:#{password}")}",
          content_type: :json,
          accept: :json
        }
      )
  
      data = JSON.parse(response.body)
      data['access_token']
    rescue RestClient::ExceptionWithResponse => e
      # Handle any errors or exceptions here
      # For example, you can log the error and return nil
      Rails.logger.error("Error fetching access token: #{e.response}")
      nil
    end
  end
  
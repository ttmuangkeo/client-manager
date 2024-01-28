# app/controllers/brytecore_auth_controller.rb

class BrytecoreAuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :authenticate

  def authenticate
    provided_username = params[:username]
    provided_password = params[:password]

    if valid_credentials?(provided_username, provided_password)
      access_token = fetch_access_token(provided_username, provided_password)
      render json: {access_token: access_token}
    else
      render json: {error: 'Invalid Creds'}, status: :unauthorized
    end
  end
  
  private

    def valid_credentials?(provided_username, provided_password)
      expected_username = ENV['BRYTECORE_USERNAME']      
      expected_password = ENV['BRYTECORE_PASSWORD']

      provided_username == expected_username && provided_password == expected_password
    end

    def fetch_access_token(username, password)
      res = RestClient.post(
        "#{Rails.application.config.base_auth_brytecore_url}/oauth/token",
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
      data = JSON.parse(res.body)
      data['access_token']
    rescue Restclient::ExceptionWithResponce => e 
      Rails.logger.error("error fetch token: #{e.res}")
      nil
    end
end
  
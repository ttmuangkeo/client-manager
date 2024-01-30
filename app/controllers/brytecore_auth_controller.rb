# app/controllers/brytecore_auth_controller.rb

class BrytecoreAuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :authenticate

  def authenticate
    provided_username = params[:username]
    provided_password = params[:password]

    auth_service = AuthenticationService.new 
    expected_username = ENV['BRYTECORE_USERNAME'] || ''
    expected_password = ENV['BRYTECORE_PASSWORD'] || ''
    
    result = auth_service.authenticate(
      provided_username,
      provided_password,
      expected_username,
      expected_password,
      "#{Rails.application.config.base_auth_brytecore_url}/oauth/token"
    )

    if result[:success]
      render json: {access_token: result[:access_token]}
    else
      render json: {error: 'invalid creds'}, status: :unauthorized
    end
  end
end
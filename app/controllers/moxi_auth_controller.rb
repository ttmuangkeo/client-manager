class MoxiAuthController < ApplicationController
  include MoxiAuthHelper
  skip_before_action :verify_authenticity_token, only: :authenticate
  
  def authenticate
      provided_username = params[:username]
      provided_password = params[:password]

      result = login(provided_username, provided_password)

      if result
        render json: { data: result[:data] }
      else
        render json: { error: 'Authentication failed' }, status: :unauthorized
      end
    end
    

    def logout
      perform_logout
      render json: {message: 'logout success'}
    end
  
    def show
      result = fetch_moxi_data('companies')
  
      if result[:success]
        render json: { companies: result[:data] }
      else
        render json: { error: 'failed to get company data' }, status: :internal_server_error
      end
    end
  end
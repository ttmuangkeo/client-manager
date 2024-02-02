class MoxiAuthController < ApplicationController
  include MoxiAuthHelper
  skip_before_action :verify_authenticity_token, only: :authenticate
  
  def authenticate
      provided_username = params[:username]
      provided_password = params[:password]

      result = login(provided_username, provided_password)

      if result[:success]
        company_data_result = fetch_company_data
        
        if company_data_result[:success]
          render json: { data: company_data_result[:data] }
        else
          render json: { error: "Failed to fetch company data: #{company_data_result[:error]}" }, status: :internal_server_error
        end
      else
        render json: { error: 'Authentication failed' }, status: :unauthorized
      end
    end
    

    def logout
      perform_logout
      render json: {message: 'logout success'}
    end
  
    def show
      session_data = session[:moxi_session]
  
      if session_data.present?
        cookie = session_data[:cookie]
        creds = session_data[:creds]
  
        result = fetch_moxi_data(cookie, creds, 'companies')
  
        if result[:success]
          render json: { companies: result[:data] }
        else
          render json: { error: 'Failed to get company data' }, status: :internal_server_error
        end
      else
        render json: { error: 'User is not authenticated' }, status: :unauthorized
      end
    end
  end
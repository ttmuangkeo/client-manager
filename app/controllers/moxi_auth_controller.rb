class MoxiAuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :authenticate
  
  def authenticate
      provided_username = params[:username]
      provided_password = params[:password]

      reset_session_cookie
  
      result = fetch_moxi_company_data(provided_username, provided_password)
  
      if result[:success]
        session[:moxi_session_cookie] = result[:session_cookie]
        Rails.logger.info("Authentication successful. Session cookie: #{result[:session_cookie]}")
  
        render json: { 
          data: result[:data],
          session_cookie: result[:session_cookie]
        }
      else
        render json: { error: 'Authentication failed' }, status: :unauthorized
      end
    end
  
    def fetch_moxi_company_data(username, password)
      moxi_session_cookie = session[:moxi_session_cookie] # Check if the session cookie is present
  
      headers = {
        Authorization: "Basic #{Base64.strict_encode64("#{username}:#{password}")}",
        content_type: 'application/x-www-form-urlencoded',
        accept: 'application/vnd.moxi-platform+json;version=1'
      }
  
      # Include the session cookie in the headers if available
      headers['Cookie'] = "_wms_svc_public_session=#{moxi_session_cookie}" if moxi_session_cookie
  
      begin
        response = RestClient.get("#{Rails.application.config.base_moxi_url}/companies", headers)
        session[:moxi_session_cookie] = response.cookies['_wms_svc_public_session']
        Rails.logger.info("Data fetching successful. Session cookie: #{session[:moxi_session_cookie]}")
        data = JSON.parse(response.body)
        { success: true, data: data, session_cookie: session[:moxi_session_cookie] }
      rescue RestClient::ExceptionWithResponse => e
        Rails.logger.error("Error fetching company data: #{e.response}")
      end
    end
  
    def show
      company_result = fetch_moxi_company_data(params[:username], params[:password])
  
      if company_result[:success]
        render json: { companies: company_result[:companies] }
      else
        render json: { error: 'failed to get company data' }, status: :internal_server_error
      end
    end

    private
    
    def reset_session_cookie
      session.delete(:moxi_session_cookie)
    end
  end
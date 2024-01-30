class MoxiAuthController < ApplicationController
    def authenticate
        provided_username = params[:username]
        provided_password = params[:password]
    
        # Call a service or method to authenticate and fetch data from the external API
        result = AuthenticationService.fetch_moxi_company_data(provided_username, provided_password)
    
        if result[:success]
          render json: { data: result[:data] }
        else
          render json: { error: 'Authentication failed' }, status: :unauthorized
        end
    end

    def show
        company_result = AuthenticationService.fetch_moxi_company_data

        if company_result[:success]
            render json: {company_result[:companies]}
        else
            render json: {error: 'failed to get comapny data'}, status: :internal_server_error
        end
    end
end

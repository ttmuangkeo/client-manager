class MoxiAuthController < ApplicationController
    def fetch_company_data
        provided_username = params[:username]
        provided_password = params[:password]

        company_data_result = AuthenticationService.fetch_moxi_company_data(provided_username, provided_password)

        if company_data_result[:success]
            render json: {company_data: company_data_result[:company_data]}
        else
            render json: {error: 'failed to get fetch company data'}, status: :internal_server_error
        end
    end
end

class BrytecoreCompaniesController < ApplicationController
    def show
        begin
          company_id = params[:id]
          access_token = request.headers['Authorization']&.split(' ')&.last
          Rails.logger.debug("Access Token: #{access_token}")

          response = RestClient.get("https://api.brytecore.com/companies/#{company_id}", {
            Authorization: "Bearer #{access_token}",
            content_type: :json,
            accept: :json
          })
    
          data = JSON.parse(response.body)
          render json: { success: true, data: data }
        rescue RestClient::ExceptionWithResponse => e
          Rails.logger.error("Error fetching company data: #{e.response}")
          render json: { success: false, error: 'Failed to fetch company data' }, status: :internal_server_error
        end
      end
end

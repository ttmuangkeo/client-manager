class BrytecoreCompaniesController < ApplicationController
    def show
        begin
          company_id = params[:id]
          access_token = request.headers['Authorization']&.split(' ')&.last

          if access_token.blank?
            Rails.logger.error('access token was not provided or you need to create a new one')
            render json: {success: false, error: "access token expired or was not provided"}, status: :unauthorized
            return
          end

          Rails.logger.debug("Access Token: #{access_token}")
          response = RestClient.get("#{Rails.application.config.base_api_brytecore_url}/companies/#{company_id}", {
            Authorization: "Bearer #{access_token}",
            content_type: :json,
            accept: :json
          })
    
          data = JSON.parse(response.body)
          render json: { success: true, data: data }
        rescue RestClient::ExceptionWithResponse => e
          Rails.logger.error("Error fetching company data: #{e.response}")
          render json: { success: false, error: 'Failed to fetch company data' }, status: e&.response&.code || :internal_server_error
          rescue StandardError => e 
            Rails.logger.error("Unexpected error: #{e.message}")
            render json: {success: false, error: 'Unexpected error'}, status: :internal_server_error
        end
      end

      def api_keys
        begin
        company_id = params[:id]
        access_token = request.headers['Authorization'].split(' ').last

        response = RestClient.get("#{Rails.application.config.base_api_brytecore_url}/apikeys/#{company_id}", {
          Authorization: "Bearer #{access_token}",
          content_type: :json,
          accept: :json
        })
        api_keys_data = JSON.parse(response.body)
        render json: {success: true, data: api_keys_data}
        rescue RestClient::ExceptionWithResponse => e 
          Rails.logger.error("erro fetching api keys: #{e.response}")
          render json: {success: false, error: 'failed to fetch api keys'}
      end
    end

end

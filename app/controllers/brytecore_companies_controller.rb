class BrytecoreCompaniesController < ApplicationController
    def get_company
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

      def get_all_company
        begin
          access_token = request.headers['Authorization']&.split(' ')&.last
          page = (params[:page] || 1).to_i
          per_page = (params[:per_page] || 10).to_i
      
          response = RestClient.get("#{Rails.application.config.base_api_brytecore_url}/companies", {
            Authorization: "Bearer #{access_token}",
            content_type: :json,
            accept: :json
          })
      
          parsed_response = JSON.parse(response.body)
          data = parsed_response["data"] # Adjust this key if necessary to access the companies array

          paginate_data = Kaminari.paginate_array(data).page(page).per(per_page)
      
          render json: {
            success: true,
            companies: paginate_data.as_json,
            current_page: paginate_data.current_page,
            total_pages: paginate_data.total_pages,
            total_count: paginate_data.total_count
          }
        rescue RestClient::ExceptionWithResponse => e
          render json: { success: false, error: 'Failed to get all company data' }, status: e&.response&.code || :internal_server_error
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

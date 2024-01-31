module MoxiAuthHelper


    def login(username, password)
        result = fetch_moxi_data(username, password, 'companies')
        if result[:success]
            session[:moxi_credentials] = {username: username, password: password}
            {success: true, data: result[:data]}
        else
            {success: false, error: 'authne erro'}
        end
    end

    def perform_logout
        session.delete(:moxi_credentials)
    end

    def authenticate_request
        credentials = session[:moxi_credentials]
        if credentials
            yield(credentials)
        else
            {success: false, error: "user is not auth"}
        end
    end

    def fetch_moxi_data(username, password, endpoint)
        Rails.logger.info("Stored credentials: #{username} and #{password}")
        headers = {
            Authorization: "Basic #{Base64.strict_encode64("#{username}:#{password}")}",
            Content_Type: 'application/x-www-form-urlencoded',
            Accept: 'application/vnd.moxi-platform+json;version=1'
        }        
        begin
            Rails.logger.info("Request to #{Rails.application.config.base_moxi_url}/#{endpoint} with headers: #{headers}")
            response = RestClient.get("#{Rails.application.config.base_moxi_url}/#{endpoint}", headers)

            data =JSON.parse(response.body)

            {success: true, data: data}
        rescue RestClient::ExceptionWithResponse => e
            Rails.logger.error("Error fetching data #{endpoint}: #{e.response}")
            {success: false, error: "Failed to get data"}
        end
    end
end

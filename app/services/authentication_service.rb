class AuthenticationService
    def authenticate(username, password, expected_username, expected_password, auth_url)
        if valid_credentials?(username, password, expected_username, expected_password)
            access_token = fetch_access_token(username, password, auth_url)
            {success: true, access_token: access_token}
        else
            {success: false, error: 'Invalid Creds'}
        end
    end

    private

    def valid_credentials?(provided_username, provided_password, expected_username, expected_password) 
        provided_username == expected_username && provided_password == expected_password
    end
    
    
    def fetch_access_token(username, password, auth_url)
        response = RestClient.post(
            auth_url,
            {
                grant_type: 'client_credentials',
                scope: '*'
            },
            {
                Authorization: "Basic #{Base64.strict_encode64("#{username}:#{password}")}",
                content_type: :json,
                accept: :json
            }
        )
        data = JSON.parse(response.body)
        data['access_token']
        rescue RestClient::ExceptionWithResponse => e
            Rails.logger.error("error fetching token: #{e.response}")
            nil
    end
end
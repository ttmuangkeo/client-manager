module MoxiAuthHelper

def login(username, password)
    Rails.logger.info("Stored credentials: #{username} and #{password}")
    headers = {
        Authorization: "Basic #{Base64.strict_encode64("#{username}:#{password}")}",
        Content_Type: 'application/x-www-form-urlencoded',
        Accept: 'application/vnd.moxi-platform+json;version=1'
    }
    
    begin
        Rails.logger.info("Request to #{Rails.application.config.base_moxi_url}/companies with headers: #{headers}")
    
        response = RestClient.get("#{Rails.application.config.base_moxi_url}/companies", headers)
        cookie = extract_cookie_from_response(response)
        creds = headers[:Authorization]
    
        store_cookies(cookie)
        store_basic_auth_creds(username, password)
        store_session_data(cookie, creds)

        token = SecureRandom.hex(32)
        store_token(token)
        { success: true, token: token}
    rescue RestClient::ExceptionWithResponse => e
        Rails.logger.error("Error authing: #{e.response}")
        { success: false, error: "Failed to authenticate" }
    end
    end
    def store_token(token)
        session[:moxi_token] = token
    end

    def extract_cookie_from_response(response)
    cookie_header = response.headers[:set_cookie]

    if cookie_header.is_a?(Array)
        cookie_header = cookie_header.join(' ')
    end

    cookie_match = /_wms_svc_public_session=(\S+);/.match(cookie_header)
    cookie_match[1] if cookie_match
    end

    def fetch_moxi_data(cookie, creds, endpoint)
        headers = {
        Cookie: "_wms_svc_public_session=#{cookie}",
        Authorization: "Basic #{creds}",
        Accept: 'application/vnd.moxi-platform+json;version=1',
        Content_Type: 'application/x-www-form-urlencoded',
        }
    
        begin
        response = RestClient.get("#{Rails.application.config.base_moxi_url}/#{endpoint}", headers)
        data = JSON.parse(response.body)
    
        { success: true, data: data }
        rescue RestClient::ExceptionWithResponse => e
        Rails.logger.error("Failed to get data at endpoint #{endpoint}: #{e.response}")
        { success: false, error: 'Failed to get data' }
        end
    end

    def store_cookies(cookie)
        session[:moxi_cookie] = cookie
    end
    def store_basic_auth_creds(username, password)  
    creds = "Basic #{Base64.strict_encode64("#{username}:#{password}")}"
    session[:moxi_basic_auth] = creds
    end

    def store_session_data(cookie, creds)
    session[:moxi_session] = { cookie: cookie, creds: creds }
    end

    def perform_logout
        session.delete(:moxi_basic_auth)
        session.delete(:moxi_session)
    end
    def fetch_company_data
        cookie = session[:moxi_cookie]
        creds = session[:moxi_basic_auth]
    
        if cookie.present? && creds.present?
          fetch_moxi_data(cookie, creds, 'companies')
        else
          { success: false, error: 'User is not authenticated' }
        end
      end    
end

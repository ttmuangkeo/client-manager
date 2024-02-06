class MoxiListingController < ApplicationController
    include MoxiAuthHelper
    skip_before_action :verify_authenticity_token

    def fetch_all_listing_data

        session_data = session[:moxi_session]
        moxi_works_company_id = params[:moxi_works_company_id]


        if session_data.present?
        cookie = session_data["cookie"]
        creds = session_data["creds"]
        Rails.logger.info("#{cookie}, #{creds}")
        result = fetch_moxi_data(cookie, creds, "listings?moxi_works_company_id=#{moxi_works_company_id}")
        
        if result[:success]
            render json: { data: result[:data] }
        else
            render json: { error: 'Failed to fetch data' }, status: :internal_server_error
        end
        else
        render json: { error: 'User is not authenticated' }, status: :unauthorized
        end
    end
    def fetch_listing_data

        session_data = session[:moxi_session]
        moxi_works_company_id = params[:moxi_works_company_id]
        moxi_works_listing_id = params[:moxi_works_listing_id]


        if session_data.present?
        cookie = session_data["cookie"]
        creds = session_data["creds"]
        Rails.logger.info("#{cookie}, #{creds}")
        result = fetch_moxi_data(cookie, creds, "listings/#{moxi_works_listing_id}?moxi_works_company_id=#{moxi_works_company_id}")
        
        if result[:success]
            render json: { data: result[:data] }
        else
            render json: { error: 'Failed to fetch data' }, status: :internal_server_error
        end
        else
        render json: { error: 'User is not authenticated' }, status: :unauthorized
        end
    end
end

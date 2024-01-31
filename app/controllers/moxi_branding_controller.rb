class MoxiBrandingController < ApplicationController
  include MoxiAuthHelper
  skip_before_action :verify_authenticity_token

  def fetch_branding_data
    authenticate do |credentials|
      moxi_works_company_id = params[:moxi_works_company_id]
      result = fetch_moxi_data(credentials[:username], credentials[:password], "brands/#{moxi_works_company_id}")

      if result[:success]
        render json: {branding_data: result[:data]}
      else render json: {error: "failed to get branding data: #{result}"}
      end
    end
  end
end

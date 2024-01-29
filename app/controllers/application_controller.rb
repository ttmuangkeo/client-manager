# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :set_cors_headers, if: -> { request.method != 'OPTIONS' }


  def index
    # Assuming your Vue.js entry point is in app/assets/javascripts/src/index.html.erb
    render file: 'app/assets/javascripts/src/main.js', layout: false
  end

  private

  def set_cors_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
end

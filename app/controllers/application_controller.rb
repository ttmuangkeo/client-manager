# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  def index
    # Assuming your Vue.js entry point is in app/assets/javascripts/src/index.html.erb
    render file: 'app/assets/javascripts/src/main.js', layout: false
  end
end

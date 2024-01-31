require 'test_helper'

class MoxiBrandingControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch_branding_data" do
    get moxi_branding_fetch_branding_data_url
    assert_response :success
  end

end

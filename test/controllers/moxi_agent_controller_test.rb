require 'test_helper'

class MoxiAgentControllerTest < ActionDispatch::IntegrationTest
  test "should get fetchAgentData" do
    get moxi_agent_fetchAgentData_url
    assert_response :success
  end

end

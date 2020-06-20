require 'test_helper'

class TakumarequestControllerTest < ActionDispatch::IntegrationTest
  test "should get join" do
    get takumarequest_join_url
    assert_response :success
  end

end

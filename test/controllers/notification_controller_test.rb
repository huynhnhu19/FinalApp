require 'test_helper'

class NotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get event:string" do
    get notification_event:string_url
    assert_response :success
  end

end

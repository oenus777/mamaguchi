require 'test_helper'

class FollowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get followings_index_url
    assert_response :success
  end

end

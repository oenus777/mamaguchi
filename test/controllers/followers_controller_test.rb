require 'test_helper'

class FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get followers_index_url
    assert_response :success
  end

end

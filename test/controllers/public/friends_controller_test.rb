require "test_helper"

class Public::FriendsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get public_friends_followings_url
    assert_response :success
  end

  test "should get followers" do
    get public_friends_followers_url
    assert_response :success
  end
end

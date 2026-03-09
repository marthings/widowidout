require "test_helper"

class LeaderboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "unauthenticated access redirects to login" do
    get leaderboard_url
    assert_redirected_to new_session_url
  end

  test "should show leaderboard" do
    sign_in @user
    get leaderboard_url
    assert_response :success
  end

  test "leaderboard includes users with counters" do
    sign_in @user
    get leaderboard_url
    assert_response :success
    assert assigns(:leaders).any?
  end
end

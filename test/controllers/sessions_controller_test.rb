require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new (login form)" do
    get new_session_url
    assert_response :success
  end

  test "should create session with valid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_redirected_to root_url
  end

  test "should not create session with wrong password" do
    post session_url, params: { email_address: @user.email_address, password: "wrong" }
    assert_redirected_to new_session_url
  end

  test "should not create session with unknown email" do
    post session_url, params: { email_address: "nobody@example.com", password: "password" }
    assert_redirected_to new_session_url
  end

  test "should destroy session (logout)" do
    sign_in @user
    delete session_url
    assert_redirected_to new_session_url
  end

  test "after logout, accessing counters redirects to login" do
    sign_in @user
    delete session_url
    get counters_url
    assert_redirected_to new_session_url
  end
end

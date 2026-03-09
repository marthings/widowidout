require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new (forgot password form)" do
    get new_password_url
    assert_response :success
  end

  test "create redirects to login with notice when email exists" do
    post passwords_url, params: { email_address: @user.email_address }
    assert_redirected_to new_session_url
    assert_not_nil flash[:notice]
  end

  test "create redirects to login even when email does not exist" do
    post passwords_url, params: { email_address: "nobody@example.com" }
    assert_redirected_to new_session_url
    assert_not_nil flash[:notice]
  end

  test "edit with invalid token redirects to new_password" do
    get edit_password_url(token: "invalid_token")
    assert_redirected_to new_password_url
  end

  test "edit with valid token shows reset form" do
    token = @user.password_reset_token
    get edit_password_url(token: token)
    assert_response :success
  end

  test "update with valid token resets password" do
    token = @user.password_reset_token
    patch password_url(token: token), params: { password: "newpassword", password_confirmation: "newpassword" }
    assert_redirected_to new_session_url
    assert @user.reload.authenticate("newpassword")
  end

  test "update with mismatched passwords redirects back with alert" do
    token = @user.password_reset_token
    patch password_url(token: token), params: { password: "newpassword", password_confirmation: "different" }
    assert_redirected_to edit_password_url(token: token)
    assert_not_nil flash[:alert]
  end
end

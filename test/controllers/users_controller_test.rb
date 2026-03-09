require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "unauthenticated edit redirects to login" do
    get edit_users_url
    assert_redirected_to new_session_url
  end

  test "should get edit" do
    sign_in @user
    get edit_users_url
    assert_response :success
  end

  test "should update name" do
    sign_in @user
    patch users_url, params: { user: { name: "New Name" } }
    assert_redirected_to edit_users_url
    assert_equal "New Name", @user.reload.name
  end

  test "should update email" do
    sign_in @user
    patch users_url, params: { user: { email_address: "updated@example.com" } }
    assert_redirected_to edit_users_url
    assert_equal "updated@example.com", @user.reload.email_address
  end

  test "should not update with duplicate email" do
    other = users(:two)
    sign_in @user
    patch users_url, params: { user: { email_address: other.email_address } }
    assert_response :unprocessable_entity
  end
end

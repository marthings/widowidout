require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new (registration form)" do
    get new_registration_url
    assert_response :success
  end

  test "should create user with valid params" do
    assert_difference("User.count") do
      post registration_url, params: {
        user: {
          email_address: "new@example.com",
          password: "secret123",
          password_confirmation: "secret123"
        }
      }
    end
    assert_redirected_to root_url
  end

  test "should not create user with mismatched passwords" do
    assert_no_difference("User.count") do
      post registration_url, params: {
        user: {
          email_address: "new@example.com",
          password: "secret123",
          password_confirmation: "different"
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should not create user with duplicate email" do
    existing = users(:one)
    assert_no_difference("User.count") do
      post registration_url, params: {
        user: {
          email_address: existing.email_address,
          password: "secret123",
          password_confirmation: "secret123"
        }
      }
    end
    assert_response :unprocessable_entity
  end
end

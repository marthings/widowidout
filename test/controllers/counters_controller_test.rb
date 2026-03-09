require "test_helper"

class CountersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @counter = counters(:one)
  end

  # --- Unauthenticated access ---

  test "unauthenticated index redirects to login" do
    get counters_url
    assert_redirected_to new_session_url
  end

  test "unauthenticated new redirects to login" do
    get new_counter_url
    assert_redirected_to new_session_url
  end

  # --- Authenticated access ---

  test "should get index" do
    sign_in @user
    get counters_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_counter_url
    assert_response :success
  end

  test "should create counter with valid params" do
    sign_in @user
    assert_difference("Counter.count") do
      post counters_url, params: { counter: { title: "New Counter", emoji: "🎯", amount: 0, color: "#ffffff", goal: 5 } }
    end
    assert_redirected_to counters_url
  end

  test "should not create counter without title" do
    sign_in @user
    assert_no_difference("Counter.count") do
      post counters_url, params: { counter: { title: "", emoji: "🎯", amount: 0 } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    sign_in @user
    get edit_counter_url(@counter)
    assert_response :success
  end

  test "should update counter with valid params" do
    sign_in @user
    patch counter_url(@counter), params: { counter: { title: "Updated Title" } }
    assert_redirected_to counters_url
    assert_equal "Updated Title", @counter.reload.title
  end

  test "should not update counter without title" do
    sign_in @user
    patch counter_url(@counter), params: { counter: { title: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy counter" do
    sign_in @user
    assert_difference("Counter.count", -1) do
      delete counter_url(@counter)
    end
    assert_redirected_to counters_url
  end

  test "should increment counter" do
    sign_in @user
    original_amount = @counter.amount
    patch increment_counter_url(@counter)
    assert_redirected_to counters_url
    assert_equal original_amount + 1, @counter.reload.amount
  end

  test "should decrement counter" do
    sign_in @user
    original_amount = @counter.amount
    patch decrement_counter_url(@counter)
    assert_redirected_to counters_url
    assert_equal original_amount - 1, @counter.reload.amount
  end

  test "should not decrement counter below zero" do
    sign_in @user
    @counter.update!(amount: 0)
    patch decrement_counter_url(@counter)
    assert_redirected_to counters_url
    assert_equal 0, @counter.reload.amount
  end
end

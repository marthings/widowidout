require "test_helper"

class UserTest < ActiveSupport::TestCase
  # --- Validations ---

  test "valid with email and password" do
    user = User.new(email_address: "test@example.com", password: "secret123")
    assert user.valid?
  end

  test "invalid without email" do
    user = User.new(password: "secret123")
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "invalid with duplicate email" do
    existing = users(:one)
    user = User.new(email_address: existing.email_address, password: "secret123")
    assert_not user.valid?
    assert user.errors[:email_address].any?
  end

  test "normalizes email to lowercase and strips whitespace" do
    user = User.create!(email_address: "  UPPER@EXAMPLE.COM  ", password: "secret123")
    assert_equal "upper@example.com", user.email_address
  end

  # --- Authentication ---

  test "authenticate_by returns user with correct password" do
    user = users(:one)
    authenticated = User.authenticate_by(email_address: user.email_address, password: "password")
    assert_equal user, authenticated
  end

  test "authenticate_by returns nil with wrong password" do
    user = users(:one)
    result = User.authenticate_by(email_address: user.email_address, password: "wrong")
    assert_nil result
  end

  # --- Associations ---

  test "has many counters" do
    user = users(:one)
    assert_respond_to user, :counters
    assert user.counters.any?
  end

  test "has many sessions" do
    user = users(:one)
    assert_respond_to user, :sessions
  end

  test "destroys counters when user is destroyed" do
    user = users(:one)
    counter_ids = user.counters.pluck(:id)
    user.destroy
    assert_empty Counter.where(id: counter_ids)
  end

  # --- Callbacks ---

  test "creates example counter after user creation" do
    assert_difference("Counter.count") do
      User.create!(email_address: "new@example.com", password: "secret123")
    end
  end

  # --- Instance methods ---

  test "total_amount sums all counter amounts" do
    user = users(:one)
    expected = user.counters.sum(:amount)
    assert_equal expected, user.total_amount
  end

  test "total_counters returns number of counters" do
    user = users(:one)
    assert_equal user.counters.count, user.total_counters
  end

  test "reached_goals_count counts counters where amount >= goal and goal > 0" do
    user = users(:one)
    # Set counter to reached goal
    user.counters.update_all(amount: 10, goal: 10)
    assert_equal 1, user.reached_goals_count
  end

  test "reached_goals_count excludes counters with goal 0" do
    user = users(:two)
    # counter two has goal: 0 — should not be counted even if amount >= goal
    user.counters.update_all(goal: 0, amount: 5)
    assert_equal 0, user.reached_goals_count
  end

  test "reached_goals_count excludes counters that have not reached goal" do
    user = users(:one)
    user.counters.update_all(amount: 3, goal: 10)
    assert_equal 0, user.reached_goals_count
  end
end

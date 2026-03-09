require "test_helper"

class CounterTest < ActiveSupport::TestCase
  # --- Validations ---

  test "valid with title, amount and user" do
    counter = Counter.new(title: "My Counter", amount: 0, user: users(:one))
    assert counter.valid?
  end

  test "invalid without title" do
    counter = Counter.new(amount: 0, user: users(:one))
    assert_not counter.valid?
    assert_includes counter.errors[:title], "can't be blank"
  end

  test "invalid without user" do
    counter = Counter.new(title: "My Counter", amount: 0)
    assert_not counter.valid?
    assert counter.errors[:user].any?
  end

  test "invalid with negative amount" do
    counter = Counter.new(title: "My Counter", amount: -1, user: users(:one))
    assert_not counter.valid?
    assert counter.errors[:amount].any?
  end

  test "valid with amount zero" do
    counter = Counter.new(title: "My Counter", amount: 0, user: users(:one))
    assert counter.valid?
  end

  test "valid with positive amount" do
    counter = Counter.new(title: "My Counter", amount: 100, user: users(:one))
    assert counter.valid?
  end

  # --- Associations ---

  test "belongs to user" do
    counter = counters(:one)
    assert_equal users(:one), counter.user
  end

  # --- Fixtures ---

  test "fixture one has correct data" do
    counter = counters(:one)
    assert_equal "Test Counter", counter.title
    assert_equal 5, counter.amount
    assert_equal 10, counter.goal
  end

  test "fixture two has correct data" do
    counter = counters(:two)
    assert_equal "Another Counter", counter.title
    assert_equal 3, counter.amount
    assert_equal 0, counter.goal
  end
end

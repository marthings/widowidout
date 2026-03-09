require "test_helper"

class SessionTest < ActiveSupport::TestCase
  test "belongs to user" do
    user = users(:one)
    session = user.sessions.create!(ip_address: "127.0.0.1", user_agent: "Test")
    assert_equal user, session.user
  end

  test "invalid without user" do
    session = Session.new(ip_address: "127.0.0.1")
    assert_not session.valid?
    assert session.errors[:user].any?
  end

  test "destroyed when user is destroyed" do
    user = users(:one)
    session = user.sessions.create!(ip_address: "127.0.0.1", user_agent: "Test")
    session_id = session.id
    user.destroy
    assert_nil Session.find_by(id: session_id)
  end
end

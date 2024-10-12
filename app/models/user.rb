class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :counters, dependent: :destroy

  normalizes :email_address, with: -> e { e.strip.downcase }

  after_create :create_example_counter

  private

  def create_example_counter
    counters.create(title: "Example Counter", amount: 0, goal: 10) # Adjust the attributes as needed
  end
end

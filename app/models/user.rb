class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :counters, dependent: :destroy

  normalizes :email_address, with: -> e { e.strip.downcase }

  after_create :create_example_counter

  def reached_goals_count
    counters.where("amount >= goal AND goal > 0").count
  end

  def total_amount
    counters.sum(:amount)
  end

  def total_counters
    counters.count
  end

  private

  def create_example_counter
    counters.create(title: "Example tally", amount: 0, goal: 10, color: "#7534DD", emoji: "🎉") # Adjust the attributes as needed
  end

end

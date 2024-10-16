class Counter < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_than_or_equal_to: 0, message: "Can´t go minus, sorry!" }
  validates :title, presence: true

  broadcasts_refreshes
end

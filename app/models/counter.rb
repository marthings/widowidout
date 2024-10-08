class Counter < ApplicationRecord


  validates :amount, numericality: { greater_than_or_equal_to: 0, message: "Can´t go minus, sorry!" }
end

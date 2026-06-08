class Conversion < ApplicationRecord
  belongs_to :affiliate
  belongs_to :offer
  belongs_to :click
  has_many :payout_items, dependent: :restrict_with_error

  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
end

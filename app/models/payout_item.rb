class PayoutItem < ApplicationRecord
  belongs_to :payout
  belongs_to :conversion

  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
end

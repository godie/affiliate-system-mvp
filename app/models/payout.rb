class Payout < ApplicationRecord
  belongs_to :affiliate
  has_many :payout_items, dependent: :destroy

  validates :total_conversions, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :total_amount_cents, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end

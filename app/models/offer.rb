class Offer < ApplicationRecord
  has_many :clicks, dependent: :restrict_with_error
  has_many :conversions, dependent: :restrict_with_error

  validates :name, presence: true
  validates :slug, presence: true
  validates :payout_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true
  validates :status, presence: true
  validates :attribution_window_seconds, presence: true
end

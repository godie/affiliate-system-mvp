class Affiliate < ApplicationRecord
  has_many :affiliate_domains, dependent: :destroy
  has_many :clicks, dependent: :restrict_with_error
  has_many :conversions, dependent: :restrict_with_error
  has_many :payouts, dependent: :restrict_with_error

  validates :referral_code, presence: true, uniqueness: true
end

class Click < ApplicationRecord
  belongs_to :affiliate
  belongs_to :offer
  belongs_to :affiliate_domain
  has_many :conversions, dependent: :restrict_with_error
end

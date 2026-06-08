class AffiliateDomain < ApplicationRecord
  belongs_to :affiliate
  has_many :clicks, dependent: :restrict_with_error
end

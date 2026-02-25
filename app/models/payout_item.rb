class PayoutItem < ApplicationRecord
  belongs_to :payout
  belongs_to :conversion
end

class Conversion < ApplicationRecord
  belongs_to :affiliate
  belongs_to :offer
  belongs_to :click
end

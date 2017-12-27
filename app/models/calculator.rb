class Calculator < ApplicationRecord
  validates :expression, presence: true
end

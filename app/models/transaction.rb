class Transaction < ApplicationRecord
  validates_presence_of :user_id, :amount, :status
end

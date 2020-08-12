class UserBalance < ApplicationRecord
  validates_presence_of :user_id, :balance, :balance_achieve
end

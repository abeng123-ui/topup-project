class BalanceBankHistory < ApplicationRecord
  validates_presence_of :balance_bank_id, :balance_before, :balance_after, :activity, :type, :ip, :location, :user_agent, :author
end

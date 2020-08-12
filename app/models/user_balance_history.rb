class UserBalanceHistory < ApplicationRecord
    validates_presence_of :user_balance_id, :balance_before, :balance_after, :activity, :type, :ip, :location, :user_agent, :author
end

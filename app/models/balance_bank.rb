class BalanceBank < ApplicationRecord
  validates_presence_of :balance, :balance_achieve, :code, :enable
end

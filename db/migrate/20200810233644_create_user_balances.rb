class CreateUserBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :user_balances do |t|
      t.bigint     :user_id
      t.integer    :balance
      t.integer    :balance_achieve

      t.timestamps
    end
  end
end

class CreateUserBalanceHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_balance_histories do |t|
      t.bigint      :user_balance_id
      t.integer     :balance_before
      t.integer     :balance_after
      t.string      :activity
      t.column      :type, "ENUM('credit', 'debit')"
      t.string      :ip
      t.string      :location
      t.string      :user_agent
      t.string      :author

      t.timestamps
    end
  end
end

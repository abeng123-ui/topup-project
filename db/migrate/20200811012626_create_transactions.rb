class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.bigint      :user_id
      t.integer     :amount
      t.integer     :status
      t.date        :request_date
      t.date        :purchased_date

      t.timestamps
    end
  end
end

class CreateBalanceBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :balance_banks do |t|
      t.bigint     :user_id
      t.integer    :balance
      t.integer    :balance_achieve
      t.string     :code
      t.boolean    :enable

      t.timestamps
    end
  end
end

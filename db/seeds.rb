# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
UserBalance.destroy_all
UserBalanceHistory.destroy_all
BalanceBank.destroy_all
BalanceBankHistory.destroy_all
Transaction.destroy_all

admin = User.create({
  username:             'admin',
  email:                'admin@gmail.com',
  password_digest:      BCrypt::Password.create('12345'),
  role:                 'admin',
  confirmation_token:   SecureRandom.hex(10),
  confirmation_sent_at: Time.now.in_time_zone('Asia/Jakarta').to_date,
})

user1 = User.create({
  username:             'user1',
  email:                'user1@gmail.com',
  password_digest:      BCrypt::Password.create('12345'),
  role:                 'user',
  confirmation_token:   SecureRandom.hex(10),
  confirmation_sent_at: Time.now.in_time_zone('Asia/Jakarta').to_date,
})

user2 = User.create({
  username:             'user2',
  email:                'user2@gmail.com',
  password_digest:      BCrypt::Password.create('12345'),
  role:                 'user',
  confirmation_token:   SecureRandom.hex(10),
  confirmation_sent_at: Time.now.in_time_zone('Asia/Jakarta').to_date,
})

userBalanceAdmin = UserBalance.create({
  user_id:              admin.id,
  balance:              0,
  balance_achieve:      0,
})

userBalanceUser1 = UserBalance.create({
  user_id:              user1.id,
  balance:              0,
  balance_achieve:      0,
})

userBalanceUser2 = UserBalance.create({
  user_id:              user2.id,
  balance:              0,
  balance_achieve:      0,
})

balanceBankAdmin = BalanceBank.create({
  user_id:              admin.id,
  balance:              0,
  balance_achieve:      0,
  code:                 'bca',
  enable:               true,
})

balanceBankUser1 = BalanceBank.create({
  user_id:              user1.id,
  balance:              0,
  balance_achieve:      0,
  code:                 'bca',
  enable:               true,
})

balanceBankUser2 = BalanceBank.create({
  user_id:              user2.id,
  balance:              0,
  balance_achieve:      0,
  code:                 'bca',
  enable:               true,
})


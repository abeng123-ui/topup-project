class User < ApplicationRecord
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/

  has_secure_password
  before_save :downcase_email
  before_create :generate_confirmation_instructions

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  def generate_confirmation_instructions
    self.confirmation_token = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now.in_time_zone('Asia/Jakarta').to_date
  end

  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now.in_time_zone('Asia/Jakarta').to_date
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.in_time_zone('Asia/Jakarta').to_date
    save
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end

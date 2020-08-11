class User < ApplicationRecord
  has_secure_password
  validate_length_of      :password, maximum: 72, minimum: 8, allow_nil:true, allow_blank: false

  before_validation {
    (self.email = self.email.to_s.downcase) && (self.username = self.username.to_s.downcase)
  }

  validates_presence_of     :email
  validates_uniqueness_of   :email

  def can_modify_user?(user_id)
    role == 'admin' || id.to_s == user_id.to_s
  end

  def is_admin?
    role == 'admin'
  end

end

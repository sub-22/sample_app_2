class User < ApplicationRecord
  attr_accessor :remember_token
<<<<<<< HEAD
=======

>>>>>>> 4f88919 (Chapter9: Advanced login)
  USER_PERMIT = %i(name email password password_confirmation).freeze

  VALID_EMAIL_REGEX = Settings.user.validate.format.email
  validates :name, presence: true,
    length: {maximum: Settings.user.validate.size.name}
  validates :email, presence: true,
    length: {maximum: Settings.user.validate.size.email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.user.validate.size.pass}

  has_secure_password

  before_save :downcase_email

  class << self
<<<<<<< HEAD
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::ENGINE.cost
            end
      BCrypt::Password.create string, cost: cost
=======
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
>>>>>>> 4f88919 (Chapter9: Advanced login)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_columns remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_columns remember_digest: nil
  end

  private

  def downcase_email
    email.downcase!
  end
end

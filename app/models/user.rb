class User < ApplicationRecord
  attr_accessor :remember_token
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
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::ENGINE.cost
            end
      BCrypt::Password.create string, cost: cost
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

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::ENGINE.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

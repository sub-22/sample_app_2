class User < ApplicationRecord
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

  private

  def downcase_email
    email.downcase!
  end
end

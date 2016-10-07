class User < ApplicationRecord
  attr_accessor :remember_token #has_secure_password does similar attr_accessor for password, something to associate with this object before it is written.
    # set as a new random token in the "remember" method, then hashed to produce a storable digest.
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password #makes password read-only, validates confirmation, ensures password_digest is present, loads encrypt/authenticate instance methods
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database by setting the remember_digest for that user.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns True if the remember_token's hash matches the remember_digest, False otherwise
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets the user in the database
  def forget
    update_attribute(:remember_digest, nil)
  end
end

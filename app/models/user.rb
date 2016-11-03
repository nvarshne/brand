class User < ApplicationRecord
  belongs_to :publisher, optional: true
  has_many   :proposals, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token #virtual fields.
  before_save   :downcase_email
  before_create :create_activation_digest
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password #makes password read-only, validates confirmation, ensures password_digest is present, loads encrypt/authenticate instance methods
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :check_invitation #TODO switch to before_create

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

  # Remembers a user in the database by hashing a new random token for that user.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns True if the token's hash matches the digest, False otherwise (used for remember_token and activation_token, etc.)
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets the user in the database
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    self.update_attribute(:activated,    true)
    self.update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def seller?
    self.publisher_id
  end

  def check_invitation
    invitation = Invitation.find_by(email: self.email)
    if !self.lead
      if invitation
        self.publisher_id = invitation.publisher_id
      else
        errors.add(:lead, "User needs invitation")
      end
    end
  end

  # TODO
  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    Proposal.where("user_id = ?", id)
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end

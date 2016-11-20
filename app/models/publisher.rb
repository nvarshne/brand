class Publisher < ApplicationRecord
  attr_accessor :activation_token
  has_many :sites
  has_many :users
  has_many :proposals, through: :sites
  has_many :invitations
  accepts_nested_attributes_for :users, :sites
  before_create :create_activation_digest
  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { case_sensitivity: false }

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    self.update_attribute(:activated,    true)
    self.update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    PublisherMailer.pub_activation(self).deliver_now
    self.users.each do |u|
      UserMailer.account_activation(u).deliver_now
    end
  end

  def to_s
    'Name: ' + self.name + '\n'
    'Users: ' + self.users.map { |u| u.name }.join(",") + '\n'
    'Sites: ' + self.sites.map { |s| s.name }.join(",") + '\n'
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end

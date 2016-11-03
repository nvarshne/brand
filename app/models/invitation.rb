class Invitation < ApplicationRecord
  belongs_to :publisher
  before_save :downcase_email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  def send_invite_email
    InvitationMailer.invite_send(self).deliver_now
  end

  private

    def downcase_email
      self.email = email.downcase
    end
end

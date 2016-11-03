class InvitationMailer < ApplicationMailer

  def invite_send(invitation)
    @invitation = invitation
    mail to: invitation.email, subject: "You've Been Invited!"
  end
end

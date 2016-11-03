require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test "invite_send" do
    invitation = invitations(:invitation1)
    mail = InvitationMailer.invite_send(invitation)
    assert_equal "You've Been Invited!", mail.subject
    assert_equal [invitation.email], mail.to
    assert_equal ["noreply@colab0.com"], mail.from
    assert_match CGI.escape(invitation.email), mail.body.encoded
  end

end

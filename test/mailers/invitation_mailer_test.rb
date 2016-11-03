require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test "invite_send" do
    mail = InvitationMailer.invite_send
    assert_equal "Invite send", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

require 'test_helper'

class BuyOrgMailerTest < ActionMailer::TestCase
  test "buy_activation" do
    mail = BuyOrgMailer.buy_activation
    assert_equal "Buy activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

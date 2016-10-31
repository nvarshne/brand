require 'test_helper'

class PublisherMailerTest < ActionMailer::TestCase
  test "publisher_activation" do
    publisher = publishers(:publisher1)
    publisher.activation_token = User.new_token
    mail = PublisherMailer.pub_activation(publisher)

    assert_equal "CoLab Publisher Activation", mail.subject
    assert_equal ["jkmatanle@gmail.com"],      mail.to
    assert_equal ["noreply@colab0.com"],       mail.from
    assert_match publisher.name,               mail.body.encoded
    assert_match publisher.activation_token,   mail.body.encoded
  end

end

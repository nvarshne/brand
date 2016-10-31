# Preview all emails at http://localhost:3000/rails/mailers/publisher_mailer
class PublisherMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/publisher_mailer/pub_activation
  def pub_activation
    publisher = Publisher.first
    publisher.activation_token = User.new_token
    PublisherMailer.pub_activation(publisher)
  end

end

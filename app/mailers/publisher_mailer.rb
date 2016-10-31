class PublisherMailer < ApplicationMailer

  def pub_activation(publisher)
    @publisher = publisher
    mail to: "jkmatanle@gmail.com", subject: "CoLab Publisher Activation"
  end
end

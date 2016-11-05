class PublisherMailer < ApplicationMailer

  def pub_activation(publisher)
    @publisher = publisher
    User.where(admin: true).each do |u|
      mail to: u.email, subject: "CoLab Publisher Activation"
    end
  end
end

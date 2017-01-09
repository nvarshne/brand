class BuyOrgMailer < ApplicationMailer

  def buy_activation(buyorg)
    @buyorg = buyorg
    User.where(admin: true).each do |u|
      mail to: u.email, subject: "BrandVerge Buying Org Activation"
    end
  end
end

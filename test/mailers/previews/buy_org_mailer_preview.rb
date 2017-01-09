# Preview all emails at http://localhost:3000/rails/mailers/buy_org_mailer
class BuyOrgMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/buy_org_mailer/buy_activation
  def buy_activation
    BuyOrgMailer.buy_activation
  end

end

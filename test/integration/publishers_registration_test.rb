require 'test_helper'

class PublishersRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid publisher registration information" do
    get register_path
  end

  test "valid publisher registration information" do

  end
end

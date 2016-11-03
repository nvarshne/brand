require 'test_helper'

class PublishersRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid publisher registration information" do
    get register_path
    assert_no_difference 'Publisher.count' do
      post publishers_path, params: { publisher: { name: "",
                                                   users_attributes: [] } }
    end
    assert_template 'publishers/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end


  test "valid publisher registration information" do
    get register_path
    assert_difference 'Publisher.count' do
      post publishers_path,
           params: {
             publisher: {
               name: "SomeOrg",
               users_attributes: [
                 {
                   name: "Example User",
                   email: "user@example.com",
                   password: "password",
                   password_confirmation: "password"
                 } ] } }
    end
    assert_equal 2, ActionMailer::Base.deliveries.size
    publisher = assigns(:publisher)
    assert_not publisher.activated?
    # Invalid Activation Token
    get edit_publisher_activation_path("bad_token_exe", name: publisher.name)
    assert_not publisher.reload.activated?
    # Valid Token, Bad Name
    get edit_publisher_activation_path(publisher.activation_token, name: "blah")
    assert_not publisher.reload.activated?
    # Valid Activation
    get edit_publisher_activation_path(publisher.activation_token, name: publisher.name)
    assert publisher.reload.activated?
  end
end

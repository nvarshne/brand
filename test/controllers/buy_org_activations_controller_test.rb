require 'test_helper'

class BuyOrgActivationsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get buy_org_activations_edit_url
    assert_response :success
  end

end

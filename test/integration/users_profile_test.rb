require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:james)
  end

  test "Must be logged in to display user profile" do
    get user_path(@user)
    assert_redirected_to login_url
  end

  test "profile display, show admin from any ole buyer" do
    log_in_as(users(:brody))
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.avatar'
    assert_match @user.proposals.count.to_s, response.body
    assert_select 'div.pagination'
    @user.proposals.paginate(page: 1, per_page: 15).each do |proposal|
      assert_match proposal.summary, response.body
    end
  end
end

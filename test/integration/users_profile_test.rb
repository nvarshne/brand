require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:james)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.proposals.count.to_s, response.body
    assert_select 'div.pagination'
    @user.proposals.paginate(page: 1, per_page: 15).each do |proposal|
      assert_match proposal.summary, response.body
    end
  end
end

require 'test_helper'

class ProposalsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:james)
  end

  test "proposal interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Proposal.count' do
      post proposals_path, params: { proposal: { summary: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    summary = "This proposal really ties the room together"
    assert_difference 'Proposal.count', 1 do
      post proposals_path, params: { proposal: { summary: summary } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match summary, response.body
    # Delete post
    assert_select 'a', text: 'delete'
    first_proposal = @user.proposals.paginate(page: 1).first
    assert_difference 'Proposal.count', -1 do
      delete proposal_path(first_proposal)
    end
    # Visit different user (no delete links)
    get user_path(users(:brody))
    assert_select 'a', text: 'delete', count: 0
  end
end
require 'test_helper'

class ProposalsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @proposal = proposals(:example_adspace)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Proposal.count' do
      post proposals_path, params: { proposal: { summary: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Proposal.count' do
      delete proposal_path(@proposal)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong proposal" do
    log_in_as(users(:james))
    proposal = proposals(:other_space)
    assert_no_difference 'Proposal.count' do
      delete proposal_path(proposal)
    end
    assert_redirected_to root_url
  end
end

require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  def setup
    @user = users(:james)
    @proposal = @user.proposals.build(summary: "Lorem ipsum")
  end

  test "should be valid" do
    assert @proposal.valid?
  end

  test "user id should be present" do
    @proposal.user_id = nil
    assert_not @proposal.valid?
  end

  test "summary should be present" do
    @proposal.summary = "   "
    assert_not @proposal.valid?
  end

  test "summary should be at most 140 characters" do
    @proposal.summary = "a" * 141
    assert_not @proposal.valid?
  end

  test "order should be most recent first, 'default scope'" do
    assert_equal proposals(:most_recent), Proposal.first
  end
end

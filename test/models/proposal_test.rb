require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  def setup
    @seller = sellers(:seller1)
    @site = sites(:site1)
    @proposal = @seller.proposals.build(summary: "Lorem ipsum", site: @site)
  end

  test "setup should be valid" do
    assert @proposal.valid?
  end

  test "seller id should be present" do
    @proposal.seller_id = nil
    assert_not @proposal.valid?
  end

  test "site id should be present" do
    @proposal.site_id = nil
    assert_not @proposal.valid?
  end

  test "summary should be present" do
    @proposal.summary = " " * 2
    assert_not @proposal.valid?
  end

  test "summary should be at most 200 characters" do
    @proposal.summary = "a" * 201
    assert_not @proposal.valid?
  end

  test "order should be most recent first, 'default scope'" do
    assert_equal proposals(:most_recent), Proposal.first
  end
end

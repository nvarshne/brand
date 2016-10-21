require 'test_helper'

class SellerTest < ActiveSupport::TestCase

  def setup
    user = users(:james)
    publisher = publishers(:publisher1)
    @seller = Seller.new(user: user, publisher: publisher)
  end

  test "setup should be valid" do
    assert @seller.valid?
  end

  test "user id should be present" do
    @seller.user_id = nil
    assert_not @seller.valid?
  end

  test "publisher id should be present" do
    @seller.publisher_id = nil
    assert_not @seller.valid?
  end

  test "associated proposals should be destroyed" do
    site = sites(:site1)
    @seller.save
    @seller.proposals.create!(summary: "Lorem ipsum", site: site)
    assert_difference 'Proposal.count', -1 do
      @seller.destroy
    end
  end
end

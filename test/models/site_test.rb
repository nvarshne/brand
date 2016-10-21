require 'test_helper'

class SiteTest < ActiveSupport::TestCase

  def setup
    publisher = publishers(:publisher1)
    @site = publisher.sites.create!(name: "Sporty", url: "Sporty.com")
  end

  test "setup should be valid" do
    assert @site.valid?
  end

  test "publisher id should be present" do
    @site.publisher_id = nil
    assert_not @site.valid?
  end

  test "name should be present" do
    @site.name = " "
    assert_not @site.valid?
  end

  # TODO more strict
  test "url should be present" do
    @site.url = " "
    assert_not @site.valid?
  end
end

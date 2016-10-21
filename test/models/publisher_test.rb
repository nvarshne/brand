require 'test_helper'

class PublisherTest < ActiveSupport::TestCase

  def setup
    @publisher = Publisher.new(name: "Wadup Inc.")
  end

  test "setup should be valid" do
    assert @publisher.valid?
  end

  test "name should be valid" do
    @publisher.name = " "
    assert_not @publisher.valid?
  end
end

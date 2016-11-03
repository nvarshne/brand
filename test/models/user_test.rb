require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar",
                     lead: true)
  end

  test "setup should be valid" do
    assert @user.valid?
  end

  test "name validation should reject absence" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email validation should reject absence" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name validation should reject long name" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email validation should reject long email" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.co.uk alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email validation should require uniqueness" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be nonblank" do
    @user.password = @user.password_confirmation = " " * 4
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for user will nil digest" do
    @user.remember_digest = nil
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated proposals should be destroyed" do
    site = sites(:site1)
    @user.save
    @user.proposals.create!(summary: "Lorem ipsum", site: site)
    assert_difference 'Proposal.count', -1 do
      @user.destroy
    end
  end
end

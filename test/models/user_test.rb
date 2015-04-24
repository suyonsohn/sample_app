require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Kim", email: "kim@kim.ca")
  end

  test "should be valid" do
    assert @user.valid?
  end
end

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    # Visit the login path.
    get login_path
    # Verify that the new sessions form renders properly.
    assert_template 'sessions/new'
    # Post to the sessions path with an invalid params hash.
    post login_path, session: { email: "", password: "" }
    # Verify that the new sessions form gets re-rendered and a flash message appears.
    assert_template 'sessions/new'
    assert_not flash.empty?
    # Visit another page(such as the Home page).
    get root_path
    # Verify that the flash message doesn't appear on the new page.
    assert flash.empty?
  end

  test "login with valid information" do
    # Visit the login path.
    get login_path
    # Post valid information to the sessions path.
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # Verify that the login link disappears.
    assert_select "a[href=?]", login_path, count: 0
    # Verify that a logout link appears.
    assert_select "a[href=?]", logout_path
    # Verify that a profile link appears.
    assert_select "a[href=?]", user_path(@user)
  end

end

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:linh)
  end

  test "login with invalid information" do
  	get login_path # visit the login path
  	assert_template 'sessions/new' # verify that the new session form renders properly
  	post login_path, params: {session:{email:"", password:""}} # post to sessions path with an invalid params hash
  	assert_template 'sessions/new' # verify that the new session form get re-renderd
  	assert_not flash.empty? # and that a flash messege appears
  	get root_path # visit another page
  	assert flash.empty? # verify that the flash message doesn't appear on the new page
  end

  test "login with valid information" do
    get login_path
    post login_path, params: {session:{email: @user.email, password: 'password'}}
    assert_redirected_to @user # check right redirect target
    follow_redirect!            # actually visit redirected page
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password'}}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # simulate a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end
  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end

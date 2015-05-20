require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "users non-logged-in layout links" do
  	get root_path
  	assert_template 'static_pages/home'
  	assert_select "a[href=?]", root_path, count: 2
  	assert_select "a[href=?]", help_path
  	assert_select "a[href=?]", about_path
  	assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path, count: 1
    get signup_path
    assert_select "title", full_title("Sign up")

  end

  test "users logged-in layout links" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", signup_path, count: 0
  end
end

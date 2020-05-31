require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]",root_path, count: 2 #header
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", 'http://rubyonrails.org/' 
    assert_select "a[href=?]", about_path #footer
    assert_select "a[href=?]", contact_path
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links when logged in" do #??演習10.41??
    get root_path
    assert_template 'static_pages/home'
    log_in_as(@user)
    # assert_select "a[href=?]", logout_path
  end

end

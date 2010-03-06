require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def test_should_show_user
    get :show, :id => users(:patrick)
    assert_response :success
    assert_template 'show'
    assert_equal users(:patrick), assigns(:user)
  end
  
  def test_should_show_submitted_shares
    get :show, :id => users(:patrick)
    assert_select 'div#shares_submitted div.share', :count => 2
  end
  
  def test_should_show_shares_voted_on
    get :show, :id => users(:patrick)
    assert_select 'div#shares_voted_on div.share', :count => 1
  end
end

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def test_should_show_login_form
    get :new
    assert_response :success
    assert_template 'new'
    assert_select 'form p', 4
  end
  
  
  # Commented out all uses of password since it is only being used as a virtual attribute
  def test_should_perform_user_login
    post :create, :login =>'patrick'# , :password => 'sekrit'
    assert_redirected_to shares_path
    assert_equal users(:patrick).id, session[:user_id]
    assert_equal users(:patrick), assigns(:current_user)
  end
  
  def test_should_fail_user_login
    post :create, :login => 'no such'# , :password => 'user'
    assert_response :success
    assert_template 'new'
    assert_nil session[:user_id]
  end
  
  def test_should_redirect_after_login_with_return_url
    post :create, { :login => 'patrick' },  # :password => 'sekrit' was in braces after :login...
      :return_to => '/shares/new'
    assert_redirected_to '/shares/new'
  end
  
  def test_should_logout_and_clear_session
    post :create, :login => 'patrick'# , :password => 'sekrit'
    assert_not_nil assigns(:current_user)
    assert_not_nil session[:user_id]
    
    delete :destroy
    assert_response :success
    assert_template 'destroy'
    assert_select 'h2', 'Logout successful'
    
    assert_nil assigns(:current_user)
    assert_nil session[:user_id]
  end
end

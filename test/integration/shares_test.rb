require "#{File.dirname(__FILE__)}/../test_helper"

class SharesTest < ActionController::IntegrationTest
  
  def test_share_submission_with_login
    get '/shares/new'
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'sessions/new'
    post '/session', :login => 'patrick',
          :password => 'sekrit'
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'shares/new'
    post '/shares', :share => {
      :title => 'Submission form Integration Test',
      :link => 'http://test.com'
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'shares/index'
  end
end
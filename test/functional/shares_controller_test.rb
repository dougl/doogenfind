require 'test_helper'

class SharesControllerTest < ActionController::TestCase
 
 def test_should_show_index
  get :index
  assert_response :success
  assert_template 'index'
  assert_not_nil assigns(:shares) 
 end
 
 def test_should_show_bin
  get :bin
  assert_response :success
  assert_template 'index'
  assert_not_nil assigns(:shares)
 end
 
 def test_should_show_new
  get_with_user :new
  assert_response :success
  assert_template 'new'
  assert_not_nil assigns(:share)
 end
 
 def test_should_show_new_form
  get_with_user :new
  assert_select 'form p', :count => 3
 end
 
 def test_should_add_share
   post_with_user :create, :share => {
     :title => 'test share',
     :link => 'http://www.test.com'
   }
   assert ! assigns(:share).new_record?
   assert_redirected_to shares_path
   assert_not_nil flash[:notice]
 end
 
 def test_should_reject_missing_share_attribute
   post_with_user :create, :share => { :title => 'share submitted without a link' }
   assert assigns(:share).errors.on(:link)
 end
 
 def test_should_show_share
  get :show, :id => shares(:one)
  assert_response :success
  assert_template 'show'
  assert_equal shares(:one), assigns(:share)
 end
 
 def test_should_show_share_vote_elements
  get_with_user :show, :id => shares(:one)
  assert_select 'h2 span#vote_score'
  assert_select 'ul#vote_history li', :count => 2
  assert_select 'div#vote_form'
 end
 
 def test_should_show_share_submitter
  get :show, :id => shares(:one)
  assert_select 'p.submitted_by a', 'patrick'
 end
 
 def test_should_indicate_not_logged_in
  get :index
  assert_select 'div#login_logout em', 'Not logged in.'
 end
 
 def test_should_show_navigation_menu 
   get :index
   assert_select 'ul#navigation li', 4
 end
 
 def test_should_indicate_logged_in_user
  get_with_user :index
  assert_equal users(:patrick), assigns(:current_user)
  assert_select 'div#login_logout em a', '(Logout)'
 end
 
 def test_should_redirect_if_not_logged_in
  get :new
  assert_response :redirect
  assert_redirected_to new_session_path
 end
 
 def test_should_store_user_with_share
  post_with_user :create, :share => {
    :title => 'share with user',
    :link => 'http://www.share-with-user.com/'
  }
  assert_equal users(:patrick), assigns(:share).user
 end
 
 def test_should_show_share_on_index
  get :index
  assert_select 'h2', 'Showing 3 most recent shares'
  assert_select 'div#content div.share', :count => 3
 end
 
 def test_should_show_shares_in_bin
  get :bin
  assert_select 'h2', 'Showing 2 upcoming shares'
  assert_select 'div#content div.share', :count => 2
 end
 
 def test_should_show_new_form
  get_with_user :new
  assert_select 'form p', :count => 5
 end
 
 def test_should_not_show_vote_button_if_not_logged_in
  get :show, :id => shares(:one)
  assert_select 'div#vote_form', false
 end
 
 def test_should_add_share_with_tags
   post_with_user :create, :share => {
     :title => 'share with tags',
     :link => 'http://www.share-with-tags.com/',
     :tag_list => 'rails, blog'
   }
   assert_equal [ 'rails', 'blog' ], assigns(:share).tag_list
 end
 
 def test_should_show_share_with_tags
    shares(:promoted).tag_list = 'apple, music'
    shares(:promoted).save
    get :show, :id => shares(:promoted).id
    assert_select 'p.tags a', 2
  end
end

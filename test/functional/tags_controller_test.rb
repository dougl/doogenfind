require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  def test_should_find_tagged_shares
    shares(:one).tag_list = 'blog', 'ruby'
    shares(:one).save
    get :show, :id => 'blog'
    assert_equal [ shares(:one) ], assigns(:shares)
  end
  
  def test_should_show_tagged_shares
    shares(:one).tag_list = 'blog', 'ruby'
    shares(:one).save
    get :show, :id => 'ruby'
    assert_response :success
    assert_template :show
    assert_select 'div#content div.share', :count => 1
  end
end

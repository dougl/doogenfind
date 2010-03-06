require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  def test_should_store_user_with_comment
    post_with_user :create, :share_id => shares(:two)
    assert_equal users(:patrick), assigns(:share).comments
  end
end

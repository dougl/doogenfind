require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  
def test_should_accept_vote
  assert shares(:two).votes.empty?
  post_with_user :create, :share_id => shares(:two)
  assert ! assigns(:share).reload.votes.empty?
end

def test_should_render_rjs_after_vote_with_ajax
  xml_http_request :post_with_user, :create, :share_id => shares(:two)
  assert_response :success
  assert_template 'create'
end

def test_should_redirect_after_vote_with_http_post  
  post_with_user :create, :share_id => shares(:two)
  assert_redirected_to share_path(shares(:two))
end

def test_should_store_user_with_vote
  post_with_user :create, :share_id => shares(:two)
  assert_equal users(:patrick), assigns(:share).votes.last.user
end
end

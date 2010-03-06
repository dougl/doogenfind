require 'test_helper'

class CommentTest < ActiveSupport::TestCase

	def test_share_association
	 assert_equal shares(:one), comments(:one).share
	end
	
	def test_should_be_associated_with_user
	 assert_equal users(:john), votes(:two).user
	end
end
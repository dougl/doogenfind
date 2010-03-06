require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def test_share_association
    assert_equal shares(:one), votes(:one).share
  end
  
  def test_should_be_associated_with_user
    assert_equal users(:john), votes(:two).user
  end
end

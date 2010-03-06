require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  def test_should_not_be_valid_without_name
    s = Share.create(:title => nil, :link => 'http://www.testsubmission.com/')
    assert s.errors.on(:title)
  end
  
  def test_should_not_be_valid_without_link
    s = Share.create(:title => 'My test submission', :link => nil)
    assert s.errors.on(:link)
  end
  
  def test_should_create_share
    s = Share.create(
    :title => 'My test submission',
    :link => 'http://www.testsubmission.com/')
    assert s.valid?
  end
  
  def test_should_have_a_votes_association
    assert_equal [ votes(:two), votes(:one) ],
    shares(:one).votes
  end
  
  def test_should_return_highest_vote_id_first
    assert_equal votes(:one), shares(:one).votes.latest.first
  end
  
  def test_should_return_3_latest_votes
    10.times { shares(:one).votes.create } 
    assert_equal 3, shares(:one).votes.latest.size
  end
  
  def test_should_be_associated_with_a_user
    assert_equal users(:patrick), votes(:one).user
  end
  
  def test_should_increment_votes_counter_cache
    shares(:two).votes.create
    shares(:two).reload
    assert_equal 1, shares(:two).attributes['votes_count']
  end
  
  def test_should_decrement_votes_counter_cache
    shares(:one).votes.first.destroy
    shares(:one).reload
    assert_equal 1, shares(:one).attributes['votes_count']
  end
  
  def test_should_cast_vote_after_creating_share
    s = Share.create(
    :title => 'Ornette Coleman',
    :link => 'http://oc.com/',
    :user => users(:patrick)
    )
    assert_equal users(:patrick), s.votes.first.user
  end
  
  def test_should_act_as_taggable
    shares(:one).tag_list ='blog, ruby'
    shares(:one).save
    assert_equal 2, shares(:one).tags.size
    assert_equal [ 'blog', 'ruby' ], shares(:one).tag_list
  end
  
  def test_should_find_tagged_with
    shares(:one).tag_list = 'blog, ruby'
    shares(:one).save
    assert_equal [ shares(:one) ],
    Share.find_tagged_with('blog')
  end
end

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :share, :counter_cache => true
end

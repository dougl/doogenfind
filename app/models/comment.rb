class Comment < ActiveRecord::Base
  belongs_to :share
  belongs_to :user
  validates_presence_of :body
end

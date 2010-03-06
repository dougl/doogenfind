class Share < ActiveRecord::Base
  acts_as_taggable
  after_create :create_initial_vote
  belongs_to :user
  validates_presence_of :title, :link
  has_many :comments
  has_many :votes do
    
     def latest
          find :all, :order => 'id DESC', :limit => 3
        end
      end

      def to_param
        "#{id}-#{title.gsub(/\W/, '-').downcase}"
      end

      protected

      def create_initial_vote
        votes.create :user => user
      end
    end


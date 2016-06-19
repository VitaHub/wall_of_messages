class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  validates :body, presence: true
  has_closure_tree
end

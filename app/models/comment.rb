class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  attribute :comment

  after_create :update_post_comment_counter
  after_destroy :update_post_comment_counter

  validates :comment, presence: true

  def update_post_comment_counter
    post.increment!(:comments_counter)
  end
end

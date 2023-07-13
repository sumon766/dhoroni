class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  attribute :content

  after_create :update_post_comment_counter
  after_destroy :update_post_comment_counter

  validates :content, presence: true

  def update_post_comment_counter
    post.increment!(:comments_counter)
  end
end

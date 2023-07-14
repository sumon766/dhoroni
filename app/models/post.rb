class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: { message: 'must be present' }
  validate :validate_title_length
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  before_save :update_user_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count + 1)
  end

  def validate_title_length
    return unless title.present? && title.length > 250

    errors.add(:title, 'is too long (maximum is 250 characters)')
  end
end

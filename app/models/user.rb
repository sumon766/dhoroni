class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  def admin?
    role == 'admin'
  end
end

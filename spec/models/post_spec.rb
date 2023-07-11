require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'validates the presence of the title' do
      post = Post.new
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include('must be present')
    end

    it 'validates the length of the title' do
      post = Post.new(title: 'This title is too long')
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates the numericality of the comments_counter' do
      post = Post.new(comments_counter: -1)
      expect(post).to_not be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'validates the numericality of the likes_counter' do
      post = Post.new(likes_counter: -1)
      expect(post).to_not be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'My first post', author: user)
      expect(post.author).to eq(user)
    end

    it 'has many comments' do
      post = Post.create(title: 'My first post')
      comment1 = Comment.create(content: 'This is a comment', post: post)
      comment2 = Comment.create(content: 'This is another comment', post: post)
      expect(post.comments).to include(comment1, comment2)
    end

    it 'has many likes' do
      post = Post.create(title: 'My first post')
      like1 = Like.create(user_id: 1, post_id: post.id)
      like2 = Like.create(user_id: 2, post_id: post.id)
      expect(post.likes).to include(like1, like2)
    end
  end

  describe 'methods' do
    it 'has a recent_comments method that returns the most recent 5 comments' do
      post = Post.create(title: 'My first post')
      comment1 = Comment.create(content: 'This is a comment', post: post, created_at: 1.day.ago)
      comment2 = Comment.create(content: 'This is another comment', post: post, created_at: 2.days.ago)
      comment3 = Comment.create(content: 'This is a third comment', post: post, created_at: 3.days.ago)
      expect(post.recent_comments).to eq([comment3, comment2, comment1])
    end
  end
end

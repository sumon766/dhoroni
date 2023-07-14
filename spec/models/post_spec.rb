require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.foreign_key).to eq('author_id')
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  let(:author) { User.create(name: 'John Doe') }

  describe 'validations' do
    it 'is valid with a title within the maximum length' do
      post = Post.new(title: 'Lorem ipsum dolor sit amet', author: author)
      expect(post).to be_valid
    end

    it 'is invalid without a title' do
      post = Post.new(author: author)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include('must be present')
    end

    it 'is invalid with a title exceeding the maximum length' do
      post = Post.new(
        id: 250,
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vel commodo nisi, sed euismod odio. Proin ultricies tortor nec leo lacinia. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vel commodo nisi, sed euismod odio. Proin ultri.', # rubocop:disable Layout/LineLength
        description: 'Test text for the description',
        comments_counter: 0,
        likes_counter: 0,
        author: author,
        created_at: nil,
        updated_at: nil
      )
      post.validate_title_length
      post.save
      expect(post).to be_invalid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'is valid with a non-negative comments counter' do
      post = Post.new(title: 'Valid Title', comments_counter: 0, author: author)
      expect(post).to be_valid
    end

    it 'is invalid with a negative comments counter' do
      post = Post.new(comments_counter: -1, author: author)
      expect(post).to be_invalid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'is valid with a non-negative likes counter' do
      post = Post.new(title: 'Valid Title', likes_counter: 0, author: author)
      expect(post).to be_valid
    end

    it 'is invalid with a negative likes counter' do
      post = Post.new(likes_counter: -1, author: author)
      expect(post).to be_invalid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe '#update_user_posts_counter' do
    it 'updates the author\'s posts_counter attribute' do
      author.update(posts_counter: 0)

      expect(author.posts_counter).to eq(0)

      Post.create(title: 'Lorem ipsum', author: author)

      expect(author.reload.posts_counter).to eq(1)
    end
  end
end

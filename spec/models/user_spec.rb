require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
      expect(user.options[:dependent]).to eq(:destroy)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
      expect(user.options[:dependent]).to eq(:destroy)
    end

    it 'has many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
      expect(user.options[:dependent]).to eq(:destroy)
    end
  end

  describe 'Validations' do
    subject { User.new(name: 'Tom', image: 'https://www.unsplash.com/photo/xyz/', bio: 'He is a learner', posts_counter: 0) }

    it { should be_valid }

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is valid without an image' do
      subject.image = nil
      expect(subject).to be_valid
    end

    it 'is not valid when posts_counter is not an integer' do
      subject.posts_counter = 'kdkkd'
      expect(subject).not_to be_valid
    end

    it 'is not valid when posts_counter is less than 0' do
      subject.posts_counter = -1
      expect(subject).not_to be_valid
    end
  end

  describe '#recent_posts' do
    let!(:user) { User.create(name: 'Tom', image: 'https://www.unsplash.com/photo/xyz/', bio: 'He is a learner', posts_counter: 0) }

    before do
      5.times do |index|
        Post.create(
          title: "Post #{index}",
          description: "This is the text for post #{index}",
          author: user,
          comments_counter: 0,
          likes_counter: 0
        )
      end
    end

    it 'returns the most recent 3 posts' do
      expect(user.recent_posts.length).to eq(3)
    end
  end
end

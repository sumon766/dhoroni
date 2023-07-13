require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq('author_id')
    end

    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq('post_id')
    end
  end

  describe 'update posts counter' do
    let(:user) { User.create(name: 'Man', image: 'photo', bio: 'bio', posts_counter: 0) }
    let(:post) do
      Post.create(title: 'post', description: 'This is my post', author_id: user.id, comments_counter: 0,
                  likes_counter: 0)
    end

    subject { described_class.create(post: post, author_id: user.id) }

    it 'updates post likes counter after create' do
      expect { subject }.to change { post.reload.likes_counter }.by(1)
    end

    it 'updates post likes counter after destroy' do
      like = subject
      expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
    end
  end
end

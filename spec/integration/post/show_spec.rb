# require 'rails_helper'
# RSpec.describe 'Posts Show Page', type: :feature do
#   let(:user) { User.create(name: 'John Doe') }
#   let(:post) { Post.create(title: 'Test Post', description: 'Test Description', author: user) }
#   let!(:comments) do
#     [
#       Comment.create(author: user, post: post, comment: 'Comment 1'),
#       Comment.create(author: user, post: post, comment: 'Comment 2'),
#       Comment.create(author: user, post: post, comment: 'Comment 3')
#     ]
#   end
#   let!(:likes) do
#     [
#       Like.create(post: post, author: user),
#       Like.create(post: post, author: user)
#     ]
#   end
#   before(:each) do
#     visit user_post_path(user, post)
#   end
#   it 'displays the post\'s title' do
#     expect(page).to have_content('Test Post')
#   end
#   it 'displays who wrote the post' do
#     expect(page).to have_content(user.name)
#   end
#   it 'displays how many comments the post has' do
#     expect(page).to have_content("Comments: #{comments.count}")
#   end
#   it 'displays how many likes the post has' do
#     expect(page).to have_content("Likes: #{likes.count}")
#   end
#   it 'displays the post body' do
#     expect(page).to have_content(post.description)
#   end
#   it 'displays the username of each commentator' do
#     comments.each do |comment|
#       expect(page).to have_content(comment.author.name)
#     end
#   end
#   it 'displays the comment each commentator left' do
#     comments.each do |comment|
#       expect(page).to have_content(comment.comment)
#     end
#   end
# end

# require 'rails_helper'

# RSpec.describe 'Posts Index Page', type: :feature do
#   before(:each) do
#     @user = User.create(name: 'John Doe', image: 'https://example.jpg', bio: 'Software Engineer', posts_counter: 5)
#     @posts = []
#     5.times do |i|
#       @posts << Post.create(title: "Post #{i + 1}", description: "Post Description #{i + 1}", author_id: @user.id)
#     end

#     @posts.each do |post|
#       post.comments.create(comment: "Comment for #{post.title}")
#     end

#     visit user_posts_path(@user)
#   end

#   it 'displays the user\'s profile picture' do
#     expect(page).to have_css('.user-image img[src^="https://example.jpg"]')
#   end

#   it 'displays the user\'s username' do
#     expect(page).to have_content(@user.name)
#   end

#   it 'displays the number of posts the user has written' do
#     expect(page).to have_content('Number of posts: 5')
#   end

#   it 'displays a post\'s title' do
#     @posts.each do |post|
#       expect(page).to have_content(post.description)
#     end
#   end

#   it 'displays some of the post\'s body' do
#     @posts.each do |post|
#       expect(page).to have_content(post.description)
#     end
#   end

#   it 'displays the first comments on a post' do
#     @posts.each do |post|
#       if post.recent_comments.any?
#         expect(page).to have_content(post.recent_comments.first.comment)
#       else
#         expect(page).to have_content(0)
#       end
#     end
#   end

#   it 'displays how many comments a post has' do
#     @posts.each do |post|
#       expect(page).to have_content("Comments: #{post.comments.count}")
#     end
#   end

#   it 'displays how many likes a post has' do
#     @posts.each do |post|
#       expect(page).to have_content("Likes: #{post.likes.count}")
#     end
#   end

#   it 'displays a section for pagination if there are more posts than fit on the view' do
#     expect(page).to have_button('Pagination')
#   end

#   it "redirects me to that post's show page when I click on a post" do
#     post_description = @posts.first.description
#     click_link post_description
#     expect(current_path).to eq(user_post_path(@user, @posts.first))
#   end
# end

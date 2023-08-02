# require 'rails_helper'

# RSpec.describe 'Posts', type: :request do
#   describe 'GET /users/:user_id/posts' do
#     it 'renders the index template' do
#       User.create(id: 5, name: 'Test User')
#       get '/users/5/posts'
#       expect(response).to have_http_status(:ok)
#       expect(response).to render_template(:index)
#     end
#   end

#   describe 'GET /users/:user_id/posts/:id' do
#     it 'renders the show template' do
#       user_id = 7
#       post_id = 14

#       user = User.create(id: user_id, name: 'Test User')

#       user.posts.create(id: post_id, title: 'Test Post')

#       get "/users/#{user_id}/posts/#{post_id}", params: { user_id: user_id, id: post_id }
#       expect(response).to have_http_status(:ok)
#       expect(response).to render_template(:show)
#     end
#   end
# end

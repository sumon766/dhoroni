require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'renders the index template' do
      get '/users/5/posts'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of all posts')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'renders the show template' do
      user_id = 7
      post_id = 14

      get "/users/#{user_id}/posts/#{post_id}", params: { user_id: user_id, id: post_id }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end

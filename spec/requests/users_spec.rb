require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users' do
    it 'renders the index template' do
      get '/users'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of all Users')
    end
  end

  describe 'GET /users/:user_id' do
    it 'renders the users by id' do
      user_id = 7
      expect { get "/users/#{user_id}" }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

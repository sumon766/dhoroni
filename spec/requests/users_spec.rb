require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users' do
    it 'renders the index template' do
      user1 = User.create(name: 'Alice')
      user2 = User.create(name: 'Bob')

      get users_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(user1.name)
      expect(response.body).to include(user2.name)
    end
  end

  describe 'GET /users/:id' do
    it 'renders the show template' do
      user = User.create(name: 'Alice', bio: 'A test user bio')
  
      user_image_url = 'https://example.com/path/to/valid_image.png'
      user.update(image: user_image_url)
  
      get user_path(user.id)
      expect(response).to have_http_status(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.bio)
  
      expect(response.body).to include(user_image_url)
    end
  end  

  describe 'GET /users/:user_id' do
    it 'renders the users by id' do
      user_image_url = 'https://example.com/path/to/valid_image.png'
      user = User.create(name: 'Sumon', posts_counter: 2, image: user_image_url)
      
      get "/users/#{user.id}"
  
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      
      expect(response.body).to include(user_image_url)
    end
  end
  
end

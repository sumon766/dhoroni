require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Mehzabien Chowdhury', image: 'https://example.jpg',
                         bio: 'She is an actress', posts_counter: 1)
    @user2 = User.create(name: 'Tasnia Farin', image: 'https://example.jpg',
                         bio: 'She is a student', posts_counter: 90)
    @user3 = User.create(name: 'Zakia Bari Momo', image: 'https://example.jpg',
                         bio: 'She is a writer', posts_counter: 6)
    visit users_path
  end

  it 'Display the username of all other users.' do
    page.has_content?(@user1.name)
    page.has_content?(@user2.name)
    page.has_content?(@user3.name)
  end

  it 'Display the profile picture for each user.' do
    expect(page.html).to include(@user1.image)
    expect(page.html).to include(@user2.image)
    expect(page.html).to include(@user3.image)
  end

  it 'Display the number of posts each user has written.' do
    expect(page.html).to have_content(@user1.posts_counter)
    expect(page.html).to have_content(@user2.posts_counter)
    expect(page.html).to have_content(@user3.posts_counter)
  end

  it 'Redirect to the users show page when clicking on a use.' do
    click_on @user2.name
    expect(current_path).to eq("/users/#{@user2.id}")
  end
end

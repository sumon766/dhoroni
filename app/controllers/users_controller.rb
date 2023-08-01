class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: %i[comments likes]).find(params[:id])
  end
end

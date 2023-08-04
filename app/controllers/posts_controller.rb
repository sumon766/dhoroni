class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:new, :create]
  before_action :authenticate_user!, only: [:new]

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.where(post_id: @posts.pluck(:id))
  end

  def show
    @post = Post.find(params[:id])
    @users = @post.author
    @index = @users.posts.order(created_at: :asc).pluck(:id).index(@post.id)
  end

  def new
    @post = @user.posts.build
  end

  def set_user
    @user = current_user
  end

  def create
    @user = @current_user
    @post = Post.new(post_params.merge(author_id: @user.id))

    if @post.save
      redirect_to user_posts_url(@user)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.author), notice: 'Post deleted successfully'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end

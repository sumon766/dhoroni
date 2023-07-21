class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = @users.posts
    @comments = Comment.where(post_id: @posts.pluck(:id))
  end

  def show
    @post = Post.find(params[:id])
    @users = @post.author
    @index = @users.posts.order(created_at: :asc).pluck(:id).index(@post.id)
  end

  def new
    @user = @current_user
    @post = Post.new
    render :new
  end

  def create
    @user = @current_user
    @post = Post.new(params.require(:post).permit(:title, :description).merge(author_id: @user.id))
    @post.author_id = @user.id

    @post.save
    redirect_to user_posts_url(@post.author_id)
  end
end

class PostsController < ApplicationController
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
    @user = @current_user
    @post = Post.new
    render :new
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

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end

class CommentsController < ApplicationController
  before_action :load_post_and_user, only: [:new, :create]
  load_and_authorize_resource except: [:new, :create]

  def new
    @comment = Comment.new
    puts "@user: #{@user}, @post: #{@post}, @comment: #{@comment}"
    render :new, locals: { comment: @comment, post: @post }
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = @user
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def destroy
    @comment.destroy
    redirect_to request.referrer, notice: 'Your comment was successfully deleted!'
  end

  private

  def load_post_and_user
    @post = Post.includes(:author).find(params[:post_id])
    @user = current_user
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

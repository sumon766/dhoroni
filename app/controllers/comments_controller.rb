class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @user = @post.author
    @comment = Comment.new
    render :new, locals: { comment: @comment, post: @post }
  end

  def create
    @user = @current_user
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(author_id: @user.id, post_id: @post.id, comment: params[:comment][:comment])
    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
end

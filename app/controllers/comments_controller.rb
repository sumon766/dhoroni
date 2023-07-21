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

    puts "params[:post_id]: #{params[:post_id]}"
    puts "@post: #{@post.inspect}"

    if @post.nil?
      redirect_to root_path
    else
      @comment = Comment.new(user_id: @user.id, post_id: @post.id, comment: params[:comment])

      flash[:error] = 'Comment could not be saved' unless @comment.save
      redirect_to user_post_path(@user, @post)
    end
  end
end

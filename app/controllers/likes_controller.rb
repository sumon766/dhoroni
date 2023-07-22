class LikesController < ApplicationController
  def create
    @post = params[:post_id]
    @user = current_user
    @like = Like.new(author: @user, post_id: @post)

    @like.save
    redirect_to user_post_path(@user.id, @post)
  end
end

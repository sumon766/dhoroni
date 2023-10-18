module Api
    class CommentsController < ApplicationController
      def index
        post = Post.find(params[:post_id])
        comments = post.comments
        render json: comments
      end
  
      def create
        post = Post.find(params[:post_id])
        comment = post.comments.new(comment_params)
        if comment.save
          render json: comment, status: :created
        else
          render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
        end
      end
  
      private
  
      def comment_params
        params.require(:comment).permit(:body)
      end
    end
end
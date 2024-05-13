class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_to request.referer, notice: "コメントしました。"
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = Post.find(params[:post_id])
    redirect_to request.referer, notice: "コメントを削除しました。"
  end
end

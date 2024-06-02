class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, except: [:index]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.score = Language.get_data(comment_params[:comment])
    @comment.post_id = @post.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = Post.find(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def ensure_guest_user
    if current_user&.guest_user?
      redirect_to request.referer, alert: "閲覧のみ可能です。ご利用の際はご登録してご利用ください。"
    end
  end
end

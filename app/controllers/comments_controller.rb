class CommentsController < ApplicationController
  before_action :authenticate_user! # Devise等のログイン要求処理

  def create
    @theme = Theme.find(params[:theme_id])
    @comment = @theme.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to theme_path(@theme), notice: "コメントを投稿しました。"
    else
      @comments = @theme.comments.includes(:user).order(created_at: :desc)
      flash.now[:alert] = "コメントの投稿に失敗しました。"
      render "themes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end

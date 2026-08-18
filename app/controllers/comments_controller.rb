class CommentsController < ApplicationController
  before_action :authenticate_user! # Devise等のログイン要求処理
  before_action :set_comment, only: [:destroy]

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

  def destroy
    theme = @comment.theme # 削除前にテーマオブジェクトを取得
    @comment.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to theme_path(theme), notice: 'コメントを削除しました' }
    end
  end

  private

  def set_comment
    # current_userの関連から取得することで、他人のコメントを削除できないよう認可処理を行う
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end

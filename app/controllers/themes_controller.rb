class ThemesController < ApplicationController
  def show
    @theme = Theme.find(params[:id])
    # comment_reactions と replies.comment_reactions もまとめて取得してN+1問題を回避
    @comments = @theme.comments.where(parent_id: nil)
                      .includes(:user, :comment_reactions, replies: [ :user, :comment_reactions ])
                      .order(created_at: :desc)
    @comment = Comment.new
  end
end

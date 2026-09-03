class ThemesController < ApplicationController
  def show
    @theme = Theme.find(params[:id])
    # parent_id: nil で親コメントのみ取得し、N+1問題防止のために replies も include します
    @comments = @theme.comments.where(parent_id: nil).includes(:user, replies: :user).order(created_at: :desc)
    @comment = Comment.new
  end
end

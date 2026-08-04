class ThemesController < ApplicationController
  def show
    @theme = Theme.find(params[:id])
    @comment = Comment.new
    # N+1問題を防止するため includes(:user) を付与
    @comments = @theme.comments.includes(:user).order(created_at: :asc)
  end
end

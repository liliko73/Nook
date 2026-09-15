class CommentReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theme_and_comment

  def create
    reaction_type = params[:reaction_type]

    # すでにリアクションが存在しているか確認
    @reaction = @comment.comment_reactions.find_by(user: current_user)

    if @reaction
      if @reaction.reaction_type == reaction_type
        # 同じリアクションをもう一度押した場合は「解除」する
        @reaction.destroy
        @reaction = nil
      else
        # 違うリアクションを押した場合は「変更」する
        @reaction.update(reaction_type: reaction_type)
      end
    else
      # まだ押していない場合は新規作成する
      @reaction = @comment.comment_reactions.create(user: current_user, reaction_type: reaction_type)
    end

    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { redirect_to theme_path(@theme) }
    end
  end

  def destroy
    @reaction = @comment.comment_reactions.find_by(user: current_user)
    @reaction&.destroy
    @reaction = nil

    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { redirect_to theme_path(@theme) }
    end
  end

  private

  def set_theme_and_comment
    @theme = Theme.find(params[:theme_id])
    @comment = @theme.comments.find(params[:comment_id])
  end
end

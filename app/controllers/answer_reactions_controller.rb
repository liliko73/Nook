class AnswerReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer

  def create
    reaction_type = params[:reaction_type]

    # すでにリアクションが存在しているか確認
    @reaction = @answer.answer_reactions.find_by(user: current_user)

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
      @reaction = @answer.answer_reactions.create(
        user: current_user,
        reaction_type: reaction_type
      )
    end

    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { redirect_to question_path(@answer.question) }
    end
  end

  def destroy
    @reaction = @answer.answer_reactions.find_by(user: current_user)
    @reaction&.destroy
    @reaction = nil

    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { redirect_to question_path(@answer.question) }
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end
end

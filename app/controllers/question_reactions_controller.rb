class QuestionReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @question.question_reactions.find_or_create_by(user: current_user)

    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { redirect_to question_path(@question) }
    end
  end

  def destroy
    @question.question_reactions.find_by(user: current_user)&.destroy

    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { redirect_to question_path(@question) }
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end

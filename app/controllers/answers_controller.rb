class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    # 自分の質問の場合は回答を作成させずにリダイレクト
    if @question.user == current_user
      redirect_to question_path(@question), alert: '自分の質問には回答できません'
      return
    end
    @answer = current_user.answers.build(answer_params)
    @answer.question = @question

    if @answer.save
      redirect_to question_path(@question), notice: '回答を投稿しました'
    else
      # 保存失敗時は質問詳細画面を再描画するため、必要な変数をセット
      @answers = @question.answers.includes(:user).order(created_at: :desc)
      flash.now[:danger] = '回答の投稿に失敗しました'
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end

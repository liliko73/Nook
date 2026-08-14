class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    # 自分の質問への「新規回答」のみ制限（返信は許可する）
    if @question.user == current_user && answer_params[:parent_id].blank?
      redirect_to question_path(@question), alert: "自分の質問には回答できません"
      return
    end

    # @question に紐づけてインスタンスを生成
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      # 親回答か返信かでメッセージを動的に変更
      notice_message = @answer.parent_id.present? ? "返信を投稿しました" : "回答を投稿しました"
      redirect_to question_path(@question), notice: notice_message
    else
      # エラー時の再描画用に親回答のみを取得し、返信とユーザー情報もまとめて取得（N+1対策）
      @answers = @question.answers.where(parent_id: nil).includes(:user, replies: :user).order(created_at: :desc)
      flash.now[:danger] = "投稿に失敗しました"
      render "questions/show", status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :parent_id)
  end
end

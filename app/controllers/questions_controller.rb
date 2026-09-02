class QuestionsController < ApplicationController
    before_action :authenticate_user!

  def index
    if params[:tab] == "mine"
      # 「あなたのAsk」: ログイン中のユーザーが投稿した質問のみを取得（新しい順）
      @questions = current_user.questions.order(created_at: :desc)
    else
      # 「みんなのAsk」: 全ての質問を取得（新しい順）
      @questions = Question.order(created_at: :desc)
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.where(parent_id: nil).includes(:user, replies: :user).order(created_at: :desc)
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to questions_path, notice: "質問を投稿しました。"
    else
      flash.now[:alert] = "質問の投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to questions_path, notice: "質問を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end

class QuestionsController < ApplicationController
    before_action :authenticate_user!

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

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end

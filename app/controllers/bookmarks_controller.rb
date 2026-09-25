class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    current_user.bookmark(@question)
    respond_to do |format|
      format.html { redirect_back fallback_location: questions_path }
      format.turbo_stream
    end
  end

  def destroy
    current_user.unbookmark(@question)
    respond_to do |format|
      format.html { redirect_back fallback_location: questions_path }
      format.turbo_stream
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end

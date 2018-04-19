class TestPageController < ApplicationController
  def top

  end

  def index
    @question = Question.new
    @questions = Question.all
  end

  def create_question
    question = Question.new(question_params)
    question.users_id = current_user.id
  end


  def question_params
    params[:question].permit(:users_id,:title, :description)
  end

end

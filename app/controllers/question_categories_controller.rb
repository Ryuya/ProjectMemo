class QuestionCategoriesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])

    @question_category = @project.question_categories.new(question_category_params)
    if @question_category.save
      flash[:success] = @project.title+"のカテゴリを作成しました"
      redirect_to project_path(params[:project_id]) and return
    else
      flash.now[:danger] = @project.title+"のカテゴリの作成に失敗しました"
      @question = Question.new
      render 'projects/show' and return
    end
  end
  
  private
  
  def question_category_params
    params.require(:question_category).permit(:category_name)
  end
end

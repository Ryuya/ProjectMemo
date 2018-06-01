class MainController < ApplicationController
  #各アクションはアクションの終了後アクション名.html.erbを暗黙にrenderする
  def index
    #@question = Question.new
    #@questions = Question.all
    @project = Project.new
    @project_category = ProjectCategory.new
    #@question_category = QuestionCategory.new
    #@candidateurls = Candidateurl.all
  end

#あるプロジェクトを押下した

#@@
  def create_project_category
    @project_category = ProjectCategory.new(project_category_params)
    if @project_category.save
      redirect_to root_path and return
    else
      redirect_to root_path and return
    end
  end
#@@
  def create_question_category
    @project = Project.find(params[:project_id])

    @question_category = @project.question_categories.new(question_category_params)
    if @question_category.save
      redirect_to project_path(params[:project_id]) and return
    else
      redirect_to project_path(params[:project_id]) and return
    end
  end

  def project_category_params
    params.require(:project_category).permit(:category_name)
  end

  def question_category_params
    params.require(:question_category).permit(:category_name)
  end

  def answerurl_params
    params.require(:answerurl).permit(:index,:url,:memo,:question_id,:user_id);
  end

  def category_params
    params(:category_name)
  end

end

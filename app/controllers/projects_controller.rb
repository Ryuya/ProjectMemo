class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    #renderとridirectを分ける
    if @project.save
      flash[:success] = "プロジェクトを作成しました"
      redirect_to root_path and return
    else
      flash.now[:danger] = "プロジェクトの作成に失敗しました"
      @project_category = ProjectCategory.new
      render 'main/index' and return
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @question_category = QuestionCategory.new
    @candidateurls = Candidateurl.all
    @project = Project.find(params[:id])
    @question = Question.new
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "プロジェクトを更新しました"
      redirect_to edit_project_path and return
    else
      flash.now[:danger] = "プロジェクトの更新に失敗しました"
      render :edit and return
    end
  end

  # 投稿を削除
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "#{@project.title}を削除しました"

    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:title,:project_category_id,:user_id);
  end
end

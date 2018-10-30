class ProjectCategoriesController < ApplicationController
  before_action :authenticate_user!
  def create
    @project_category = ProjectCategory.new(project_category_params)
    if @project_category.save
      flash[:success] = "カテゴリを追加しました"
      redirect_to root_path and return
    else
      @project = Project.new
      flash.now[:danger] = "カテゴリの追加に失敗しました"
      render "main/index" and return
    end
  end
  
  private
  
  def project_category_params
    params.require(:project_category).permit(:category_name)
  end
  
end

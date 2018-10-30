class MainController < ApplicationController
  before_action :authenticate_user!
  #各アクションはアクションの終了後アクション名.html.erbを暗黙にrenderする
  def index
    @project = Project.new
    @project_category = ProjectCategory.new
  end
end

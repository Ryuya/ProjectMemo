class MainController < ApplicationController
  def index
    @question = Question.new
    @questions = Question.all
    @project = Project.new
    @projects = Project.all

    @project_categories = ProjectCategory.all
    @question_categories = QuestionCategory.all
    @project_category = ProjectCategory.new
    @question_category = QuestionCategory.new
    @candidateurls = Candidateurl.all
  end

  def create_project
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to root_path and return
    else
      redirect_to root_path and return
    end
  end

  def create_question
    @project = Project.find(params[:project_id]);
    @question = @project.questions.new(question_params)
    @question.user_id = current_user.id
    @question.resolution = false;
    if @question.save
      redirect_to project_path(params[:project_id]) and return
    else
      redirect_to project_path(params[:project_id]) and return
    end
  end

  def create_candidateurl
    @question = Question.find(params[:question_id])
    #@answer_detail = @question.answer_details.new(answer_detail_params)
    @candidateurl = @question.candidateurls.new(candidateurl_params)
    @candidateurl.user_id = current_user.id
    @candidateurl.question_id = params[:question_id]
    url = params[:candidateurl][:url]
    agent = Mechanize.new
    page = agent.get(url)
    title = page.title
    @candidateurl.title = title


    #ここで既に同じURLが存在しているか判定する

    #存在している場合は実行しない
    if @candidateurl.save
      redirect_to question_path(params[:question_id]) and return
    else
      redirect_to question_path(params[:question_id]) and return
    end
    #存在していた場合はupdateを実行する
  end

  def resolution_update
    @project_id = Question.find(params[:question_id]).project_id
    @project = Project.find(@project_id)
    @question = @project.questions.find(params[:question_id])
    resolution_order_str = params[:order]
    results = JSON.parse(resolution_order_str)
    results.each_with_index do |result,index|
      @answerurl = @project.questions.find(params[:question_id]).answerurls.new
      @answerurl.question_id = @question.id
      @answerurl.user_id = @question.user_id

      @answerurl.answer_index = result["id"].to_s

      str_title = result["title"].to_s
      @answerurl.title = str_title.gsub(" ", "")

      str_url = result["url"].to_s
      @answerurl.url = str_url.gsub(" ", "")
      @answerurl.memo = result["memo"].to_s

      @answerurl.save
      #最後の処理まできたらboolをtrue
    end
    @question.resolution = true


    if @question.save
      redirect_to root_path and return
    else
      redirect_to question_path(params[:question_id]) and return
    end


  end

#あるプロジェクトを押下した
  def project_show
    @question_category = QuestionCategory.new
    @candidateurls = Candidateurl.all
    @question_categories = QuestionCategory.all
    @project = Project.find(params[:id])
    @question = Question.new
  end

  # 投稿を削除
  def project_destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project deleted"
    redirect_to root_path
  end

  def question_show
    @candidateurl = Candidateurl.new

    #クエリストリング
    #params
    #session[:last_question_id] = params[:project_id]
    @question = Question.find(params[:id])
    @answerurls = Question.find(params[:id]).answerurls.all
    @candidateurls = Question.find(params[:id]).candidateurls.all
    #viewからは呼べない
    #a = Candidateurl.new

    if @question.resolution == true
      render "main/close"
    else
      render "main/question_show"
    end
  end

    # 質問編集
  def question_edit
    @question = Question.find(params[:id])
    @user = User.find(current_user.id)
  end

  def project_edit
    @project = Project.find(params[:id])
    @user = User.find(current_user.id)
  end

  def project_update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to root_path and return
    else
      redirect_to project_path(params[:project_id]) and return
    end
  end

  def question_update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to root_path and return
    else
      redirect_to question_path(params[:question_id]) and return
    end
  end

  # 投稿を削除
  def question_destroy
    Question.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end

  def candidateurl_show
    #@candidateurl = Candidateurl.find(params[:id])
  end

  def candidateurl_edit
    @candidateurl = Candidateurl.find(params[:id])
    @question = Question.new
  end

  def candidateurl_update
    @candidateurl = Candidateurl.find(params[:id])
    if @candidateurl.update(candidateurl_params)
      redirect_to question_path(params[:id]) and return
    else
      redirect_to question_path(params[:id]) and return
    end
  end

  def candidateurl_destroy
    Candidateurl.find(params[:id]).destroy
    flash[:success] = "deleted"
    redirect_to question_path(params[:id]) and return
  end

  def create_project_category
    @project_category = ProjectCategory.new(project_category_params)
    if @project_category.save
      redirect_to root_path and return
    else
      redirect_to root_path and return
    end
  end

  def create_question_category
    @question_category = QuestionCategory.new(question_category_params)
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

  def question_params
    params.require(:question).permit(:title,:description,:resolution,:question_category_id,:user_id,:candidateurl_id);
  end

  def project_params
    params.require(:project).permit(:title,:project_category_id,:user_id);
  end

  def candidateurl_params
    params.require(:candidateurl).permit(:url,:memo,:user_id,:question_id);
  end

  def answerurl_params
    params.require(:answerurl).permit(:index,:url,:memo,:question_id,:user_id);
  end

  def category_params
    params(:category_name)
  end

end

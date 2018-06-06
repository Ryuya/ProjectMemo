class QuestionsController < ApplicationController
# 質問編集
  def create
    @project = Project.find(params[:project_id]);
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.project_id = @project.id
    @question.resolution = false;
    if @question.save
      flash[:success] = "質問を追加しました"
      redirect_to project_path(params[:project_id]) and return
    else
      @question_category = QuestionCategory.new
      flash.now[:danger] = "質問を追加できませんでした"
      render "projects/show" and return
    end
  end

  def show
    @candidateurl = Candidateurl.new
    @question = Question.find(params[:id])
    @answerurls = Question.find(params[:id]).answerurls.all
    @candidateurls = Question.find(params[:id]).candidateurls.all
    if @question.resolution == true
      render :close
    else
      render :show
    end
  end

  def edit
    @question = Question.find(params[:id])
    @user = User.find(current_user.id)
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = "質問を編集しました"
      redirect_to root_path and return
    else
      flash.now[:danger] = "質問の編集に失敗しました"
      render :edit and return
    end
  end

  # 投稿を削除
  def destroy
    Question.find(params[:id]).destroy
    flash[:success] = "質問を削除しました"
    redirect_to root_path
  end
  
  def abc 

  end
  def resolute
    # @project_id = Question.find(params[:question_id]).project_id
    # @project = Project.find(@project_id)
    # @question = @project.questions.find(params[:question_id])
    @question = Question.find(params[:question_id])

    resolution_order_str = params[:order]
    results = JSON.parse(resolution_order_str)
    results.each_with_index do |result,index|
      @answerurl = @question.answerurls.new
      @answerurl.question_id = @question.id
      @answerurl.user_id = @question.user_id

      @answerurl.answer_index = result["id"].to_s

      str_title = result["title"].to_s
      @answerurl.title = str_title.gsub(" ", "")

      str_url = result["url"].to_s
      @answerurl.url = str_url.gsub(" ", "")
      @answerurl.memo = result["memo"].to_s

      @answerurl.save
    end
    @question.resolution = true
    if @question.save
      redirect_to root_path and return
    else
      redirect_to question_path(params[:question_id]) and return
    end
  end
  private

  def question_params
    params.require(:question).permit(:title,:description,:resolution,:question_category_id,:user_id,:candidateurl_id);
  end
end

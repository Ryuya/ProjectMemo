class CandidateurlsController < ApplicationController
  before_action :authenticate_user!
  def create
    @question = Question.find(params[:question_id])

    @candidateurl = Candidateurl.new(candidateurl_params)
    @candidateurl.user_id = current_user.id
    @candidateurl.question_id = @question.id
    
    url = params[:candidateurl][:url]
    # エージェント(ブラウザ)のオブジェクトを作成
    agent = Mechanize.new
    # 指定したurlにgetでアクセスして、その結果をpageに代入
    page = agent.get(url)
    # candidateurlのタイトルに設定
    @candidateurl.title = page.title
    
    #ここで既に同じURLが存在しているか判定する

    #存在している場合は実行しない
    if @candidateurl.save
      flash[:success] = "URLを追加しました"
      redirect_to question_path(params[:question_id]) and return
    else
      flash.now[:danger] = "URLの作成に失敗しました"
      render "questions/show" and return
    end
    #存在していた場合はupdateを実行する
  end

  def show
    #@candidateurl = Candidateurl.find(params[:id])
  end

  def edit
    @candidateurl = Candidateurl.find(params[:id])
  end

  def update
    @candidateurl = Candidateurl.find(params[:id])
    if @candidateurl.update(candidateurl_params)
      flash[:success] = "更新しました"
      redirect_to question_path(@candidateurl.question_id) and return
    else
      
      flash.now[:danger] = "編集に失敗しました"
      render :edit and return
    end
  end

  def destroy
    candidateurl = Candidateurl.find(params[:id]).destroy
    flash[:success] = "deleted"
    redirect_to question_path(candidateurl.question) and return
  end

  private

  def candidateurl_params
    params.require(:candidateurl).permit(:title,:url,:memo,:user_id,:question_id);
  end
end

class CandidateurlsController < ApplicationController
  def create
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

  def show
    #@candidateurl = Candidateurl.find(params[:id])
  end

  def edit
    @candidateurl = Candidateurl.find(params[:id])
    @question = Question.new
  end

  def update
    @candidateurl = Candidateurl.find(params[:id])
    if @candidateurl.update(candidateurl_params)
      redirect_to question_path(@candidateurl.question_id) and return
    else
      redirect_to question_path(@candidateurl.question_id) and return
    end
  end

  def destroy
    candidateurl = Candidateurl.find(params[:id]).destroy
    flash[:success] = "deleted"
    redirect_to question_path(candidateurl.question) and return
  end

  private

  def candidateurl_params
    params.require(:candidateurl).permit(:url,:memo,:user_id,:question_id);
  end
end

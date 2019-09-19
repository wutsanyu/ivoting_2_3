class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:edit, :update, :destory, :vote]
  

  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to candidates_path, notice: "新增候選人成功"
    else
      render :new
    end
  end

  def edit
    # render layout: "backend"
    # render layout: false
  end

  def update
    if @candidate.update_attributes(candidate_params)
      redirect_to candidates_path, notice: "資料更新成功"
    else
      render :edit
    end
  end 

  def destroy
    @candidate.destroy if @candidate
    redirect_to candidates_path, notice: "候選人資料已刪除"
  end

  def vote
    @candidate.vote_logs.create(ip_address: request.remote_ip)if @candidate
    redirect_to candidates_path, notice: "完成投票"
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end

  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end
end

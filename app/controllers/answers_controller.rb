class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]

  # GET /answers or /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1 or /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
    @question = @answer.question
  end

  # POST /answers or /answers.json
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: "Answer was successfully created." }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to @question, alert: "Answer blank can't be created" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.question, notice: "Answer was successfully updated." }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @question = @answer.question
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: "Answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #Vote answer
  def vote_answer
    @vote = current_user.votes.find_by(answer_id: params[:id])
    if @vote.present?
      current_user.votes.update(note: params[:note])
    else
      @vote = current_user.votes.create(answer_id: params[:id], note: params[:note])
    end
    respond_to do |format|
      format.html { redirect_to (@vote.answer.question), notice: "Vote successfully saved." }
      format.json { render :show, status: :created, location: @vote }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:content, :picture, :picture_cache, :question_id)
    end
end

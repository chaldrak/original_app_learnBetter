class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /questions or /questions.json
  def index

    @questions = Question.all
    @title = "Top Questions"

    if params[:q] == "all"
      @questions = Question.order(created_at: :asc)
      @count = Question.count
      @title = "All Questions"
    elsif params[:q] == "solved"
      @questions = Question.where(solved: true).order(created_at: :asc)
      @count = Question.where(solved: true).count
      @title = "Solved Questions"
    elsif params[:q] == "unsolved"
      @questions = Question.where(solved: false).order(created_at: :asc)
      @count = Question.where(solved: false).count
      @title = "Unsolved Questions"
    elsif params[:quizz]
      @questions = Question.where("title LIKE ?", "%#{params[:quizz]}%").order(created_at: :asc)
      @count = Question.where("title LIKE ?", "%#{params[:quizz]}%").count
      @title = "search with '#{params[:quizz]}'"
    end
  end

  # GET /questions/1 or /questions/1.json
  def show
    @answer = Answer.new
    @favorite = current_user.favorites.find_by(question_id: @question.id) if current_user
    @vote = current_user.votes.find_by(question_id: @question.id) if current_user
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  def confirm
    @question = current_user.questions.build(question_params)
    render :new if @question.invalid?
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = current_user.questions.build(question_params)
    
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /set_good_answer
  def set_good_answer
    @question = Question.find(params[:id])
    @question.solved = true
    respond_to do |format|
      if @question.update(answer_id: params[:answer_id])
        format.html { redirect_to @question, notice: "Question was solved." }
        format.json { render :show, status: :ok, location: @question }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, alert: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :content, :picture, :picture_cache)
    end
end

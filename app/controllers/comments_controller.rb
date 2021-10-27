class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    @question = Question.find(params[:question_id]) if params[:question_id]
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @question = Question.find(params[:question_id]) if params[:question_id]
    @answer = Answer.find(params[:answer_id]) if params[:answer_id]
  end

  # GET /comments/1/edit
  def edit
    @question = Question.find(params[:question_id])
  end

  # POST /comments or /comments.json
  def create
    if params[:question_id]
      @question = Question.find(params[:question_id])
      @comment = @question.comments.new(comment_params)
    else
      @answer = Answer.find(params[:answer_id])
      @comment = @answer.comments.new(comment_params)
    end
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to (@comment.question || @answer.question), notice: "Commentaire crée avec succès." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to (@comment.question || @answer.question), alert: "Erreur d'enrégistrement. Contenu vide" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to (@comment.question || @comment.answer.question), notice: "Commentaire mis à jour." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { redirect_to (@comment.question || @comment.answer.question), alert: "Erreur de modification. Contenu vide" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    target = (@comment.question || @comment.answer.question)
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to target, alert: "Commentaire supprimé." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :question_id, :answer_id, :user_id)
    end
end

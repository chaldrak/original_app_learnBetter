class VotesController < ApplicationController
  # before_action :set_vote, only: %i[ show edit destroy ]

  # GET /votes or /votes.json
  # def index
  #   @votes = Vote.all
  # end

  # GET /votes/1 or /votes/1.json
  # def show
  # end

  # GET /votes/new
  # def new
  #   @vote = Vote.new
  # end

  # GET /votes/1/edit
  # def edit
  # end

  # POST /votes or /votes.json
  def create
    @vote = current_user.votes.build(question_id: params[:question_id], note: params[:note]) if params[:question_id]
    @vote = current_user.votes.build(answer_id: params[:answer_id], note: params[:note]) if params[:answer_id]

    respond_to do |format|
      if @vote.save
        format.html { redirect_to (@vote.question || @vote.answer.question), notice: "Vote enrégistré." }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    @vote = current_user.votes.find(params[:id])
    respond_to do |format|
      if @vote.update(note: params[:note])
        format.html { redirect_to @vote.question, notice: "Vote enrégistré." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  # def destroy
  #   @vote.destroy
  #   respond_to do |format|
  #     format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_vote
  #     @vote = Vote.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def vote_params
  #     params.require(:vote).permit(:user_id, :question_id, :answer_id, :note)
  #   end
end

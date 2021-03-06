class FavoritesController < ApplicationController
  # before_action :set_favorite, only: %i[ show edit update destroy ]

  # GET /favorites or /favorites.json
  # def index
  #   @favorites = Favorite.all
  # end

  # # GET /favorites/1 or /favorites/1.json
  # def show
  # end

  # # GET /favorites/new
  # def new
  #   @favorite = Favorite.new
  # end

  # # GET /favorites/1/edit
  # def edit
  # end

  # POST /favorites or /favorites.json
  def create
    @favorite = current_user.favorites.build(question_id: params[:question_id])

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @favorite.question, notice: "Cette question a été ajoutée à vos favoris." }
        format.json { render :show, status: :created, location: @favorite }
      end
    end
  end

  # PATCH/PUT /favorites/1 or /favorites/1.json
  # def update
  #   respond_to do |format|
  #     if @favorite.update(favorite_params)
  #       format.html { redirect_to @favorite, notice: "Favorite was successfully updated." }
  #       format.json { render :show, status: :ok, location: @favorite }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @favorite.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    question = current_user.favorites.find(params[:id]).question
    favorite = current_user.favorites.find(params[:id]).destroy
    respond_to do |format|
      
      format.html { redirect_to question, alert: "Cette question est retirée de vos favoris." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def favorite_params
    #   params.permit(:question_id)
    # end
end

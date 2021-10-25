class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update ]
  
  def index
    @users = User.order(created_at: :asc)
  end

  def show
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User profil was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :contact, :picture, :city, :university, :sector, :faculty)
    end
end

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @users = User.all
    @questions = Question.all
    @answers = Answer.all
    @comments = Comment.all
  end
end

class OrderMailer < ApplicationMailer
  def new_order_email
    @answer = params[:order]
    @sender = @answer.user
    @ecipient = @answer.question.user.email

    mail(to: @recipient, subject: "Someone answer your question!")
  end
end

class OrderMailer < ApplicationMailer
  def new_order_email
    @answer = params[:order]
    sender

    mail(to: <ADMIN_EMAIL>, subject: "You got a new order!")
  end
end

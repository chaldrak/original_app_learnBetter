class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def inbox_url
    @conversations = Conversation.all
    @conversations.each do |conversation|
      if conversation.target_user(current_user).present?
        url = conversation_messages_path(conversation)
      end
    end 
    respond_to do |format|
      if url.empty ?
        url: root_path
        format.html { redirect_to url, alert: "Vous n'avez aucune conversations" }
        format.json { head :no_content }
      end
    end
  end

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  before_action do
    I18n.locale = :fr # Or whatever logic you use to choose.
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

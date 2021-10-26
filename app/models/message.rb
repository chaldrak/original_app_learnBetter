class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :content, :conversation_id, :user_id

  def message_time
    created_at.strftime("%H:%M | %b %d")
  end

  def recipient
    recipient = self.conversation.recipient_id
    return User.find(recipient)
  end
end

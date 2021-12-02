require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'Message model test' do
    context 'Si le content du message est vide' do
      it "C'est difficile à Validation" do
        message = Message.new(content: '')
        expect(message).not_to be_valid
      end
    end
  end
end

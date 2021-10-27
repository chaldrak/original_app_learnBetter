require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'Question model test' do
    context 'Si le content de la answer est vide' do
      it "C'est difficile à Validation" do
        answer = Answer.new(content: '')
        expect(answer).not_to be_valid
      end
    end
  end
end

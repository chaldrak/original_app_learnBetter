require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Question model test' do
    context 'Si le content de la tâche est vide' do
      it "C'est difficile à Validation" do
        comment = Comment.new(content: '')
        expect(comment).not_to be_valid
      end
    end
  end
end

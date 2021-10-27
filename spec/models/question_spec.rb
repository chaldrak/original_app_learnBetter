require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Question model test' do
    context 'Si le Title de la tâche est vide' do
      it "C'est difficile à Validation" do
        question = Question.new(title: '', content: 'content-test')
        expect(question).not_to be_valid
      end
    end

    context 'Si le content de la tâche est vide' do
      it "C'est difficile à Validation" do
        question = Question.new(title: 'title', content: '')
        expect(question).not_to be_valid
      end
    end
  end
end

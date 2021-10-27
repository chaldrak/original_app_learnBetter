require 'rails_helper'

RSpec.describe "Answers", type: :system do

  context "Lors de la consultation d'une question" do
    it "On peut voir le formulaire de réponse" do
      user = FactoryBot.create(:user)
      question = FactoryBot.create(:question, user: user)
      visit root_path
      click_on "Many variations on the standard lorem ipsum text exist"
      expect(page).to have_content("Votre Réponse")
      expect(page).to have_content("Choisir une image")
    end
  end

  context "Lors de la consultation d'une question" do
    it "On peut voir les détails de la réponse" do
      user = FactoryBot.create(:user)
      question = FactoryBot.create(:question, user: user)
      answer = FactoryBot.create(:answer, content: "My answer", user: user, question: question)
      visit root_path
      click_on "Many variations on the standard lorem ipsum text exist"
      expect(page).to have_content("My answer")
    end
  end

  context "Lors de la consultation d'une question" do
    it "On peut commenter une réponse" do
      user = FactoryBot.create(:user)
      question = FactoryBot.create(:question, user: user)
      answer = FactoryBot.create(:answer, content: "My answer", user: user, question: question)
      comment = FactoryBot.create(:comment, content: "My answer comment", user: user, answer: answer)
      visit root_path
      click_on "Many variations on the standard lorem ipsum text exist"
      expect(page).to have_content("My answer comment")
    end
  end
  
end

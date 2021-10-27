require 'rails_helper'

RSpec.describe "Questions", type: :system do

  describe "Nouvelle fonction de création" do

    context "Lors de la création d'une question" do
      it "Sans le login" do
        visit root_path
        click_on "Ask Question"
        expect(page).to have_content("You need to sign in or sign up before continuing.")  
      end
    end

    context "Lors de la visite de la page d'accueil" do
      it "On peut voir les questions" do
        user = FactoryBot.create(:user)
        question = FactoryBot.create(:question, user: user)
        visit root_path
        expect(page).to have_content("Many variations on the standard lorem ipsum text exist")  
      end
    end

    context "Lors de la visite de la page d'accueil" do
      it "On peut voir les détails d'une question" do
        user = FactoryBot.create(:user)
        question = FactoryBot.create(:question, user: user)
        visit root_path
        click_on "Many variations on the standard lorem ipsum text exist"
        expect(page).to have_content("Many variations on the standard lorem ipsum text exist")
        expect(page).to have_content("test_name")
      end
    end

    context "Lors de la visite de la page d'accueil" do
      it "On peut voir les détails d'une question" do
        user = FactoryBot.create(:user)
        question = FactoryBot.create(:question, user: user)
        visit root_path
        click_on "Many variations on the standard lorem ipsum text exist"
        expect(page).to have_content("Many variations on the standard lorem ipsum text exist")
        expect(page).to have_content("test_name")
      end
    end

    context "Lors de la consultation d'une question" do
      it "On peut commenter la question" do
        user = FactoryBot.create(:user)
        question = FactoryBot.create(:question, user: user)
        comment = FactoryBot.create(:comment, content: "My question comment", user: user, question: question)
        visit root_path
        click_on "Many variations on the standard lorem ipsum text exist"
        expect(page).to have_content("My question comment")
      end
    end

    context "Lors de la visite de la page d'accueil" do
      it "On peut afficher uniquement les questions résolues" do
        user = FactoryBot.create(:user)
        question = FactoryBot.create(:question, user: user)
        answer = FactoryBot.create(:answer, user: user, question: question)
        question.update(solved: true, answer_id: answer.id)
        visit root_path
        click_on "Solved"
        expect(page).to have_content("Many variations on the standard lorem ipsum text exist")
        click_on "Unsolved"
        expect(page).not_to have_content("Many variations on the standard lorem ipsum text exist")
      end
    end

    context "Lors de la visite sur toutes les pages" do
      it "On peut rechercher une question par son contenu" do
        user = FactoryBot.create(:user)
        question = FactoryBot.create(:question, user: user)
        visit root_path
        fill_in "quizz", with: "varia\n"
        expect(page).to have_content("search with 'varia'")
        expect(page).to have_content("Many variations on the standard lorem ipsum text exist")
        visit questions_path
        fill_in "quizz", with: "varia\n"
        expect(page).to have_content("search with 'varia'")
        expect(page).to have_content("Many variations on the standard lorem ipsum text exist")
        click_on 'Register'
        fill_in "quizz", with: "varia\n"
        expect(page).to have_content("search with 'varia'")
        expect(page).to have_content("Many variations on the standard lorem ipsum text exist")
      end
    end

  end
end
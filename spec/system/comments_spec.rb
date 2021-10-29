require 'rails_helper'

RSpec.describe "Comments", type: :system do

  context "Lors de la consultation d'une question" do
    it "On peut écrire un commentaire" do
      user = login
      user1 = FactoryBot.create(:user)
      question = FactoryBot.create(:question, user: user1)
      visit questions_path
      click_on "Many variations on the standard lorem ipsum text exist"
      find(:css, 'a#comment_question').click
      fill_in "comment[content]", with: "this is my comment"
      click_on "Commenter"
      expect(page).to have_content("this is my comment")
    end
  end

  def login
    visit new_user_registration_path
    fill_in "user[name]", with: "testeur"
    fill_in "user[email]", with: "tester@example.tld"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Inscription"
    user = User.last
    user.confirm
    visit new_user_session_path
    fill_in "user[email]", with: "tester@example.tld"
    fill_in "user[password]", with: "password"
    click_button "Connexion"
    return user
  end
  
end
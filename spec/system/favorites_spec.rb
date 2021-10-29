require 'rails_helper'

RSpec.describe "Favorites", type: :system do

  context "Lors de la consultation d'une question" do
    it "On peut ajouter une question comme favoris" do
      user = login
      user1 = FactoryBot.create(:user)
      question = FactoryBot.create(:question, user: user1)
      visit questions_path
      click_on "Many variations on the standard lorem ipsum text exist"
      find(:css, 'i.fas.fa-bookmark').click
      expect(page).to have_content("Cette question a été ajoutée à vos favoris")
    end
  end

  context "Lors de la consultation d'une question" do
    it "On peut retirer une question de ses favoris" do
      user = login
      user1 = FactoryBot.create(:user)
      question = FactoryBot.create(:question, user: user1)
      visit questions_path
      click_on "Many variations on the standard lorem ipsum text exist"
      find(:css, 'i.fas.fa-bookmark').click
      find(:css, 'i.fas.fa-bookmark').click
      expect(page).to have_content("Cette question est retirée de vos favoris.")
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
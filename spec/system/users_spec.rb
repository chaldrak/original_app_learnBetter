require 'rails_helper'

RSpec.describe 'Fonction de création des utilisateur', type: :system do

  describe "Nouvelle fonction de création d'un user" do

    context "Lors de la création d'un nouvel user" do
      it "Avec une email adress vide" do
        visit new_user_registration_path
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: "test-password"
        fill_in "user[password_confirmation]", with: "test-password"
        click_button "Inscription"
        expect(page).to have_content("E-mail doit être rempli(e)")
      end
    end
    
    context "Lors de la création d'un nouvel user" do
      it "Avec une confirmation de mot de passe non conforme" do
        visit new_user_registration_path
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: "tester@example.tld"
        fill_in "user[password]", with: "test-password"
        fill_in "user[password_confirmation]", with: "new-test-password"
        click_button "Inscription"
        expect(page).to have_content("Confirmation du mot de passe ne concorde pas avec Mot de passe")
      end
    end

    context "Lors de la création d'un nouvel user" do
      it "Avec un mot de passe trop court" do
        visit new_user_registration_path
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: "tester@example.tld"
        fill_in "user[password]", with: "pass"
        fill_in "user[password_confirmation]", with: "pass"
        click_button "Inscription"
        expect(page).to have_content("Mot de passe est trop court (au moins 6 caractères)")
      end
    end

  end
end

require 'rails_helper'

RSpec.describe 'Fonction de création des utilisateur', type: :system do

  describe "Nouvelle fonction de création d'un user" do
    context "Lors de la création d'un nouvel user" do
      it "Avec des données valides un mail de confirmation est envoyé" do
        visit '/'
        click_link "Register"
        expect(current_path).to eq(new_user_registration_path)
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: "tester@example.tld"
        fill_in "user[password]", with: "test-password"
        fill_in "user[password_confirmation]", with: "test-password"
        click_button "Sign up"
        expect(current_path).to eq "/"
        expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
      end
    end

    context "Lors de la création d'un nouvel user" do
      it "Avec une email adress vide" do
        visit new_user_registration_path
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: "test-password"
        fill_in "user[password_confirmation]", with: "test-password"
        click_button "Sign up"
        expect(page).to have_content("Email can't be blank")
      end
    end
    
    context "Lors de la création d'un nouvel user" do
      it "Avec une confirmation de mot de passe non conforme" do
        visit new_user_registration_path
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: "tester@example.tld"
        fill_in "user[password]", with: "test-password"
        fill_in "user[password_confirmation]", with: "new-test-password"
        click_button "Sign up"
        expect(page).to have_content("Password confirmation doesn't match Password")
      end
    end

    context "Lors de la création d'un nouvel user" do
      it "Avec un mot de passe trop court" do
        visit new_user_registration_path
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: "tester@example.tld"
        fill_in "user[password]", with: "pass"
        fill_in "user[password_confirmation]", with: "pass"
        click_button "Sign up"
        expect(page).to have_content("Password is too short (minimum is 6 characters)")
      end
    end

  end
end

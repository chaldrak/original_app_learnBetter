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

    context "Lors de l'inscription d'un user" do
      it "Il reçoit un message de confirmation" do
        visit new_user_registration_path
        fill_in "user[name]", with: "testeur"
        fill_in "user[email]", with: "tester@example.tld"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_button "Inscription"
        expect(page).to have_content("Un message avec un lien de confirmation vous a été envoyé par mail. Veuillez suivre ce lien pour activer votre compte.")
      end
    end

    context "Lors de la connexion d'un user" do
      it "Il reçoit un message de confirmation" do
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
        expect(page).to have_content("Connecté(e).")
      end
    end

    context "Lors de la connexion d'un user" do
      it "Une fois connecté, il peut voir son profil" do
        user = login
        visit user_path(user)
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.email)
      end
    end

    context "Lors de la connexion d'un user" do
      it "Une fois connecté, il peut modifier son profil" do
        user = login
        visit user_path(user)
        find(:css, 'i.fas.fa-pencil').click
        fill_in "user[city]", with: "london"
        fill_in "user[university]", with: "pasteur"
        fill_in "user[faculty]", with: "droit"
        fill_in "user[sector]", with: "droit"
        fill_in "user[contact]", with: 90000000
        click_on "Save changes"
        expect(page).to have_content("Votre profil a été mis à jour avec succès.")
      end
    end

    context "Lors de la connexion d'un admin" do
      it "Lorsqu'un simple user tente d'accéder au pannel admin" do
        user = FactoryBot.create(:user)
        user.confirm
        visit new_user_session_path
        fill_in "user[email]", with: "test@test.com"
        fill_in "user[password]", with: "password"
        click_button "Connexion"
        visit '/admin'
        expect(page).to have_content("Vous ne disposez pas du rôle d'administrateur")
      end
    end

    context "Lors de la connexion d'un admin" do
      it "Il peut voir le bouton Admin Mode" do
        user = login
        user.update(is_admin: true)
        visit questions_path
        expect(page).to have_content("Mode Admin")
      end
    end

    context "Lors de la connexion d'un admin" do
      it "Il peut voir le bouton Admin Mode, cliquer dessus pour accéder au pannel admin" do
        user = login
        user.update(is_admin: true)
        visit questions_path
        click_on "Mode Admin"
        expect(page).to have_current_path('/admin')
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
end

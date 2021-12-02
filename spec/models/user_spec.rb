require 'rails_helper'

describe 'User model test', type: :model do
  describe 'Validation test' do
    context 'Si le email adress est vide' do
      it "La validation ne passe pas" do
        user = User.new(email: "", password:'123456')
        expect(user).not_to be_valid
      end
    end
    context 'Si le mot de passe est trop court' do
      it "La validation ne passe pas" do
        user = User.new(email: "test@test.com", password:'1234')
        expect(user).not_to be_valid
      end
    end
  end
end
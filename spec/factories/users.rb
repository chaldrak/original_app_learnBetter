FactoryBot.define do
  factory :user do
      name { 'test_name' }
      email { 'test@test.com' }
      password { "password" }
  end
end

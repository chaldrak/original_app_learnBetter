FactoryBot.define do
  factory :user do
      name { 'test_name' }
      email { 'test@test.com' }
      password { "password" }
      is_admin { true }
  end
end

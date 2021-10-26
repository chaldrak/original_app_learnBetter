FactoryBot.define do
  factory :answer do
    content { "The text is derived from Cicero's De Finibus" }
    question { 1 }
    user { 1 }
  end
end

FactoryBot.define do
  factory :comment do
    content { "The text is derived from Cicero's De Finibus" }
    question { }
    answer { }
    user { 1 }
  end
end

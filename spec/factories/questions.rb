FactoryBot.define do
  factory :question do
    title { 'Many variations on the standard lorem ipsum text exist' }
    content { 'Many variations on the standard lorem ipsum text exist' }
    user { 1 }
    solved { false }
  end
end

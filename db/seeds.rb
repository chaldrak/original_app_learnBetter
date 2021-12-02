# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(
    name: "admin LearnBetter",
    email: "chaldrakus@gmail.com",
    password: "123456",
    is_admin: true,
    uid: 2001
)

user1 = User.create!(
    name: "Joe Doe",
    email: "joe@doe.com",
    password: "123456",
    uid: 1111
)

user2 = User.create!(
    name: "Minato Namikaze",
    email: "minato@app.com",
    password: "123456",
    uid: 402
)

10.times do |n|
    User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "123456",
        uid: n
    )
end

3.times do
    Question.create!(
        title: Faker::Lorem.question(word_count: 6),
        content: Faker::Lorem.paragraphs,
        user: user1
    )
end

3.times do
    Question.create!(
        title: Faker::Lorem.question(word_count: 6),
        content: Faker::Lorem.paragraphs,
        user: user2
    )
end

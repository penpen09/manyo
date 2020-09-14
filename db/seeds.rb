# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name = Faker::Kpop.solo
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false
               )
end

User.create!(name: "Admin",
             email: "admin@admin.com",
             password: 'password',
             password_confirmation: 'password',
             admin: true
             )
10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end

10.times do |k|
  Task.create!(
  title:"task#{k + 1}",
  content: "content#{k + 1}",
  limit_date: '2020-09-14 00:00:00',
  status: '着手',
  priority: 2,
  user_id: User.first.id + k
)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{
    name: "Administrator",
    email: "adm@adm.com",
    password: "123456",
    password_confirmation: "123456",
    adm: true
    }])

100.times do
    User.create([{
        name: Faker::Name.name,
        password: '123456',
        password_confirmation: '123456',
        email: Faker::Internet.email
        }])
end

1000.times do
    Post.create([{
        content: Faker::Lorem.paragraph,
        user_id: rand(1..User.all.count())
    }])
end
    
10000.times do
    Comment.create([{
        content: Faker::Lorem.sentence,
        user_id: rand(1..User.all.count()),
        post_id: rand(1..Post.all.count())
    }])
end
    
1000.times do
    id1 = rand(1..User.all.count())
    id2 = rand(1..User.all.count())
    Friend.create([{
        asker_id: id2,
        replyer_id: id1,
        accepted: true
    }])
    Friend.create([{
        asker_id: id1,
        replyer_id: id2,
        accepted: true
    }])
end
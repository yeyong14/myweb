#enccoding:utf-8
namespace :db do
  desc "填写样例数据到数据库"
  task populate: :environment do
   admin =  User.create!(name:"Example User",
                 email: "example@railstutorial.org",
                 password: 123456,
                 password_confirmation: 123456)
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
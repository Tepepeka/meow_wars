# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy all
Order.destroy_all
OrderProduct.destroy_all
Cart.destroy_all
Comment.destroy_all
Likeable.destroy_all
User.destroy_all
Product.destroy_all

# Users create
20.times do |i|
  name = Faker::Name.first_name
  User.create(
      email:"#{name}@yopmail.com",
      password:"foobar",
      password_confirmation:"foobar"
  )
  puts "*"*(i+1)
  puts "#{i+1} user(s) created"
end

# Admin create
User.create(email:"tppk@love", password:"tepepeka", password_confirmation:"tepepeka", admin:true)
puts "Admin created"

# Product create
12.times do |i|
  image_url = "http://placekitten.com/300/300"
  Product.create(
      image_url: image_url,
      name:Faker::Creature::Cat.name,
      description:Faker::Movies::StarWars.quote,
      price:rand(1.00..99.95).round(2)
  )
  puts "*"*(i+1)
  puts "#{i+1} Product(s) created"
end

# Cart create
User.all.each_with_index do |user, i|
  Cart.create(user_id: user.id)
  puts "*"*(i+1)
  puts "#{i+1} Cart(s) created"
end

# Comment create
50.times do |i|
  Comment.create(
      body:Faker::Movies::StarWars.quote,
      product_id:Product.all.sample.id,
      user_id:User.all.sample.id
  )
  puts "*"*(i+1)
  puts "#{i+1} Comment(s) created"
end

# Like create
50.times do |i|
  Likeable.create(
      product_id:Product.all.sample.id,
      user_id:User.all.sample.id
  )
  puts "*"*(i+1)
  puts "#{i+1} Like(s) created"
end
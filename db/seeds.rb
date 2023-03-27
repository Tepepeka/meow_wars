# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy all
Product.destroy_all

Product.create(name:"Pif", description:"Pif le chien", price:29.95)
Product.create(name:"Hercule", description:"Hercule le chat", price:59.95)
Product.create(name:"Diabolo", description:"les fous du volant 1", price:14.95)
Product.create(name:"Satanas", description:"les fous du volant 2", price:19.95)
Product.create(name:"Tom", description:"Warner Bros 1", price:69.95)
Product.create(name:"Jerry", description:"Warner Bros 2", price:99.95) 
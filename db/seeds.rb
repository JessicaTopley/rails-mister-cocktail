# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

json_url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

json = open(json_url).read

ingredients = JSON.parse(json)

Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

ingredients["drinks"].each do |ingredient|
  new_ingredient = Ingredient.create(name: ingredient["strIngredient1"])
  # puts "#{new_ingredient.name} is created"
end

puts "Ingredient: #{Ingredient.count}"

Cocktail.create(name: "Mojito")
Cocktail.create(name: "Margarita")

puts "Cocktail: #{Cocktail.count}"

Dose.create!(description:"two spoons", ingredient: Ingredient.first, cocktail: Cocktail.first)








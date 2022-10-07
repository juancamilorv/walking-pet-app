# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'json'

puts 'Cleaning database...'
Service.destroy_all
Pet.destroy_all
User.destroy_all


# Cloudinary::Uploader.upload("san_francisco.jpg")

i = 0

10.times do
  user = User.new
  if rand < 0.5
    user.name = Faker::Name.female_first_name
  else
    user.name = Faker::Name.male_first_name
  end
  user.email = Faker::Internet.email(name: user.name)
  user.password = 'password'
  user.password_confirmation = 'password'
  user.address = Faker::Address.street_address
  user.phone_number = Faker::PhoneNumber.cell_phone_in_e164
  user.region = REGIONS.sample
  user.city = COLOMBIA[user.region].sample
  user.petwalker = rand < 0.5

  if user.petwalker
    user.description = Faker::Lorem.paragraph
    user.price_per_hour = rand(5000..8000)
  else
    pet = Pet.new
    pet.user = user
    pet.name = 'My pet'
    pet.save!
  end

  user.photo.attach(io: URI.open(IMAGES[i]), filename: "nes.png", content_type: "image/png")


  user.save!
  if user.petwalker
    puts "User #{user.name} created!"
  else
    puts "User #{user.name} created! Pet => #{pet.name}"
  end
  i += 1
end

require 'faker'
require 'open-uri'
require 'geocoder'

Bike.destroy_all
User.destroy_all

users = [
  { email: "fonsecarik@gmail.com", first_name: "Erik", last_name: "Fon", password: "1234567890" },
  { email: "fonsecari@gmail.com", first_name: "Eri", last_name: "Fons", password: "1234567890" },
  { email: "fonseca@gmail.com", first_name: "Er", last_name: "Fon", password: "1234567890" },
  { email: "fon@gmail.com", first_name: "Erikkos", last_name: "Fotol", password: "1234567890" },
  { email: "fondit@gmail.com", first_name: "Emil", last_name: "Fontol", password: "1234567890" }
]

users.each do |user|
  User.create!(user)
end

puts "user create"
puts "create bikes"

def generate_full_address
  street_address = Faker::Address.street_address
  city = 'Amsterdam'
  country = 'Netherlands'
  postal_code = Faker::Address.postcode

  "#{street_address}, #{city}, #{postal_code}, #{country}"
end

def geocode_address(address)
  results = Geocoder.search(address)
  if results.any?
    coordinates = results.first.coordinates
    { latitude: coordinates[0], longitude: coordinates[1] }
  else
    { latitude: nil, longitude: nil }
  end
end

50.times do
  full_address = generate_full_address
  geocoded_data = geocode_address(full_address)
  image_url = "https://loremflickr.com/320/240/bicycle"
  bike = Bike.new(
    bike_type: Bike::BIKE_TYPES.sample,
    description: Faker::Vehicle.standard_specs,
    manufacturer: Faker::Vehicle.manufacturer,
    model: Faker::Vehicle.model,
    available: true,
    rating: rand(1...5),
    price_per_day: rand(50..350),
    user_id: User.ids.sample,
    address: full_address,
    latitude: geocoded_data[:latitude],
    longitude: geocoded_data[:longitude]
  )
  image_file = URI.open(image_url)
  bike.photos.attach(
    io: image_file,
    filename: "bike_photo_#{rand(1000)}.jpg",
    content_type: 'image/jpg'
  )
  bike.save!
end

puts "seed bikes done"

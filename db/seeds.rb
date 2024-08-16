require 'faker'
require 'open-uri'
require 'geocoder'
require 'unsplash'
require 'net/http'
require 'json'
require 'securerandom'

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
  [
    { street_address: "713, Haarlemmerweg", postcode: "1067 HP" },
    { street_address: "76A, Liergouw", postcode: "1028 BV" },
    { street_address: "48G, Nieuwe Keizersgracht", postcode: "1018 DS" },
    { street_address: "39-H, Valeriusstraat", postcode: "1071 MD" },
    { street_address: "13, Amstelkade", postcode: "1078 AB" },
    { street_address: "94A, Madurastraat", postcode: " 1094 GT" },
    { street_address: "7, Sardiniëweg", postcode: "1044 AG" },
    { street_address: "687, Jan Tooropstraat", postcode: "1061 AE" },
    { street_address: "18-H, Kribbestraat", postcode: "1079 WR" },
    { street_address: "9, Dinarpromenade", postcode: "1060 SH" },
    { street_address: "24-1, Archimedeslaan", postcode: "1098 PV" },
    { street_address: "48, Diepenbeekplantsoen", postcode: "1066 KJ" },
    { street_address: "1A-2, Overamstelstraat", postcode: "1091 TL" },
    { street_address: "224, Kadoelenweg", postcode: "1035 NN" },
    { street_address: "12-1, Robert Kochplantsoen", postcode: "1097 GH" },
    { street_address: "6, W.J. Knoopstraat", postcode: "1025 KP" },
    { street_address: "18, Tijnmuiden", postcode: "1046 AL" },
    { street_address: "57-H, Plantage Kerklaan", postcode: "1018 CW" },
    { street_address: "285, Waterpoortweg", postcode: "1051 PV" },
    { street_address: "763, Henk Sneevlietweg", postcode: "1066 VH" },
    { street_address: "12-1, Solebaystraat", postcode: "1055 ZR" },
    { street_address: "6-H, Starrenboschstraat", postcode: "1097 MD" },
    { street_address: "18, Korianderstraat", postcode: "1104 HR" },
    { street_address: "400, Beethovenstraat", postcode: "1082 PR" },
    { street_address: "1, NDSM-pier", postcode: "1033 RG" },
    { street_address: "DUC Dierencrematorium Amsterdam, 221, Kadoelenweg", postcode: "1035 NH" },
    { street_address: "69, Anton Waldorpstraat", postcode: "1062 AX" },
    { street_address: "5, Stationsplein", postcode: "1012 AB" },
    { street_address: "42A, Papaverweg", postcode: "1032 KJ" },
    { street_address: "26B, Tom Schreursweg", postcode: "1067 MC" },
    { street_address: "2C, Hofgeest", postcode: "1102 EA" },
    { street_address: "43-1, Burgemeester Rendorpstraat", postcode: "1064 EM" },
    { street_address: "250, Buyskade", postcode: "1051 ME" },
    { street_address: "36, Louis Bouwmeesterstraat", postcode: "1065 KW" },
    { street_address: "53, Jollenpad", postcode: "1081 KC" },
    { street_address: "137-4, Van Ostadestraat", postcode: "1072 SW" },
    { street_address: "10E, De Leeuw van Vlaanderenstraat", postcode: "1061 CS" },
    { street_address: "11, Poederooienstraat", postcode: "1106 CE" },
    { street_address: "59-1, Tilanusstraat", postcode: "1091 BE" },
    { street_address: "4, Baron Schimmelpenninck van der Oyeweg", postcode: "1067 HV" },
    { street_address: "30, Geldersekade", postcode: "1012 BJ" },
    { street_address: "93, Plesmanlaan", postcode: "1066 XS" },
    { street_address: "23-1, Schinkelkade", postcode: "1075 VH" },
    { street_address: "769, IJburglaan", postcode: "1087 CH" },
    { street_address: "8A, Paasheuvelweg", postcode: "1105 BH" },
    { street_address: "769, IJburglaan", postcode: "1087 CH" },
    { street_address: "8A, Paasheuvelweg", postcode: "1105 BH" },
    { street_address: "3-1, Fijnje van Salverdastraat", postcode: "1065 EA" },
    { street_address: "207, Van der Palmkade", postcode: "1051 RK" },
    { street_address: "74, Kollenbergweg", postcode: "1101 AV" },
    { street_address: "1, Drostenburg", postcode: "1102 AM" }
  ]
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


def fetch_image_url
  uri = URI("https://api.unsplash.com/photos/random?client_id=#{ENV['UNSPLASH_ACCESS_KEY']}&query=bicycle&count=50")
  response = Net::HTTP.get(uri)
  json_response = JSON.parse(response)
  json_response.first['urls']['regular']
end

counter = 1
generate_full_address.each do |address|

  full_address = "#{address[:street_address]}, #{address[:postcode]}, Amsterdam, Netherlands"
  geocoded_data = geocode_address(full_address)

  bike = Bike.new(
    bike_type: Bike::BIKE_TYPES.sample,
    description: Faker::Vehicle.standard_specs.join(", "),
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

  image_file = URI.open(fetch_image_url)
  bike.photos.attach(
    io: image_file,
    filename: "bike_photo_#{SecureRandom.uuid}.jpg",
    content_type: 'image/jpg'
  )
  bike.save!
  print "created #{counter} bikes \\\r"
  counter += 1
end

puts "seed bikes done"

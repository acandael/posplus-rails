Fabricator(:researcher) do
  name {  Faker::Name.name }
  bio { Faker::Lorem.paragraph(2) }
  email { Faker::Internet.email }
  image { Rack::Test::UploadedFile.new(
      "./spec/support/uploads/monk.jpg",
      "application/jpg"
    ) 
  }
  visible true
end

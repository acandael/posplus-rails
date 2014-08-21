Fabricator(:publication) do
  title { Faker::Lorem.words(5).join(' ') }
  year 2014
  body { Faker::Lorem.paragraph(2) }
  visible true
end

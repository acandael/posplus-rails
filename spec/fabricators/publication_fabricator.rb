Fabricator(:publication) do
  title { Faker::Lorem.words(5).join(' ') }
  reference { Faker::Lorem.paragraph(2) }
  visible true
end

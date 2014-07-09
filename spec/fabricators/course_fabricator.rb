Fabricator(:course) do
  title { Faker::Lorem.words(5).join(" ") }
end

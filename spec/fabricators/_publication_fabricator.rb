Fabricator(:publication) do
  title { Faker::Lorem.words(5).join(' ') }
end

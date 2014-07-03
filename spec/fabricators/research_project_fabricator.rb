Fabricator(:research_project) do
  title { Faker::Lorem.words(5).join(" ") }
  body { Faker::Lorem.paragraph(2) }
end

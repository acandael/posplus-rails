Fabricator(:research_theme) do
  title { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(2) }
end

Fabricator(:news_item) do
  title { Faker::Lorem.words(5).join(" ") }
  body { Faker::Lorem.paragraph(2) }
  document "vergadering.docx"
  link { Faker::Internet.url } 
end

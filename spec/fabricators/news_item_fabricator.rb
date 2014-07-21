Fabricator(:news_item) do
  title { Faker::Lorem.words(5).join(" ") }
  body { Faker::Lorem.paragraph(2) }
  image { Rack::Test::UploadedFile.new(
      "./spec/support/uploads/jigsaw-puzzle.jpg",
      "application/jpg"
    ) 
  }
  document { Rack::Test::UploadedFile.new(
      "./spec/support/uploads/vergadering.docx",
      "application/docx"
    ) 
  }
  link { Faker::Internet.url } 
  visible true
end

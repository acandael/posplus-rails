Fabricator(:research_project) do
  title { Faker::Lorem.words(5).join(" ") }
  body { Faker::Lorem.paragraph(2) }
  image { Rack::Test::UploadedFile.new(
      "./spec/support/uploads/jigsaw-puzzle.jpg",
      "application/jpg"
    ) 
  }
end

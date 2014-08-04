Fabricator(:research_group) do
  name { Faker::Name.name }
  image { Rack::Test::UploadedFile.new(
      "./spec/support/uploads/jigsaw-puzzle.jpg",
      "application/jpg"
    ) 
  }
  website { Faker::Internet.url } 
end

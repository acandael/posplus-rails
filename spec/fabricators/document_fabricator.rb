Fabricator(:document) do
  file { Rack::Test::UploadedFile.new(
      "./spec/support/uploads/vergadering.docx",
      "application/docx"
    ) 
  }
end

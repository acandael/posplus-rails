Fabricator(:researcher) do
  name {  Faker::Name.name }
  bio { Faker::Lorem.paragraph(2) }
  email { Faker::Internet.email }
end

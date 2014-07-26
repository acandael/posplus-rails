require 'spec_helper'

feature "Visitor interacts with data page" do
  scenario 'visitor clicks on data link on research theme page and views data page' do
    research_theme = Fabricate(:research_theme)
    publication = Fabricate(:publication)
    document = Fabricate(:document)
    publication.documents << document
    publication.save

    visit research_theme_path(research_theme)
    click_link "Data"

    expect(page).to have_css 'h1', text: "Data"
    expect(page).to have_css 'h1', text: publication.title
    expect(page).to have_css 'a', text: File.basename(document.file.url)
  end

  scenario 'visitor sees no data available for publication without documents' do
    research_theme = Fabricate(:research_theme)
    publication = Fabricate(:publication)

    visit research_theme_path(research_theme)
    click_link "Data"

    expect(page).to have_content "no data available"
  end
end

require 'spec_helper'

feature 'About page' do
  scenario 'visitor visits about page' do
    visit pages_about_path
    expect(page).to have_css 'h1', text: "About POS+"
  end

  scenario 'visitor sees affiliated research groups' do
    research_group = Fabricate(:research_group)
    visit pages_about_path
    within('aside') { expect(page).to have_css 'h2', text: "Affiliated Research Groups" }
    within('aside') { expect(page).to have_css 'p', text: research_group.name }
    within('aside') { page.should have_xpath("//a[@href='#{research_group.website}']") }
    within('aside') { page.should have_xpath("//img[@src=\"#{research_group.image.url(:thumb)}\"]") }
  end
end

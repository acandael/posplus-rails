require 'spec_helper'

feature 'Publication Series page' do
  scenario 'visitor visits publication series page' do
    visit series_path
    expect(page).to have_css 'h1', "POS+ Publication Series"
  end

  scenario 'visitor visits publication series page and view working papers' do
    publication = Fabricate(:publication)
    category = Fabricate(:category)
    category.name = "working_paper"
    category.save
    publication.category_id = category.id 
    publication.save
    publication.reload
    visit series_path
    expect(page).to have_css 'a', text: publication.title
  end

  scenario 'visitor visits publication series page and views technical reports' do
    publication = Fabricate(:publication)
    category = Fabricate(:category)
    category.name = "technical report"
    category.save
    publication.category_id = category.id 
    publication.save
    publication.reload
    visit series_path
    expect(page).to have_css 'li', text: publication.title
  end
end

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

  scenario 'visitor sees a year folder for each publication year' do
    publication_2014 = Fabricate(:publication)
    publication_2013 = Fabricate(:publication)
    publication_2013.created_at = "2013-01-01 00:00:00 UTC"
    category = Fabricate(:category)
    category.name = "technical report"
    category.save
    publication_2014.category_id = category.id
    publication_2014.save
    publication_2013.category_id = category.id
    publication_2013.save
    visit series_path
    within('aside') { expect(page).to have_css 'a', text: publication_2014.created_at.strftime('%Y') }
    within('aside') { expect(page).to have_css 'a', text: publication_2013.created_at.strftime('%Y') }
  end

  scenario 'visitor views publication series archive' do
    publication = Fabricate(:publication)
    category = Fabricate(:category)
    category.name = "technical report"
    category.save
    publication.category_id = category.id
    publication.save
    visit series_path
    within('aside') { click_link publication.created_at.strftime('%Y') }
    expect(page).to have_css 'h1', text: "POS+ Publication Series Archive"
    expect(page).to have_css 'h2', text: "#{publication.created_at.strftime('%Y')}"
    expect(page).to have_css 'li', text: publication.title
  end

  scenario 'visitor should see publication for a given year in archive' do
    publication_2014 = Fabricate(:publication)
    publication_2013 = Fabricate(:publication)
    publication_2013.created_at = "2013-01-01 00:00:00 UTC"
    category = Fabricate(:category)
    category.name = "technical report"
    category.save
    publication_2014.category_id = category.id
    publication_2014.save
    publication_2013.category_id = category.id
    publication_2013.save
    visit series_path
    within('aside') { click_link publication_2014.created_at.strftime('%Y') }
    expect(page).to have_css 'li', text: publication_2014.title
    expect(page).not_to have_css 'li', text: publication_2013.title
  end
end

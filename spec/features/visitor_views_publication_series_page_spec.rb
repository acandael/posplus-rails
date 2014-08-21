require 'spec_helper'

feature 'Publication Series page' do
  scenario 'visitor visits publication series page' do
    visit series_path
    expect(page).to have_css 'h1', "POS+ Publication Series"
  end

  scenario 'visitor visits publication series page and view working papers' do
    publication = Fabricate(:publication)
    publication.series = 2
    category = Fabricate(:category)
    category.name = "working_paper"
    category.save
    publication.category_id = category.id 
    document1 = Fabricate(:document)
    document2 = Fabricate(:document)
    publication.documents << document1
    publication.documents << document2
    publication.save
    publication.reload
    visit series_path
    expect(page).to have_css 'li', text: publication.body
    expect(page).to have_css 'li', text: "( 2 )"
    expect(page).to have_css 'a', text: "Download"
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
    expect(page).to have_css 'li', text: publication.body
  end

  scenario 'visitor click on download link besides publication and sees documents for publication' do
    publication = Fabricate(:publication)
    category = Fabricate(:category)
    category.name = "working_paper"
    category.save
    publication.category_id = category.id
    document1 = Fabricate(:document)
    document2 = Fabricate(:document)
    publication.documents << document1
    publication.documents << document2
    publication.save
    visit series_path
    find("a[href='/publications/#{publication.id}']").click
    expect(page).to have_css 'a', text: File.basename(document1.file.url) 
    expect(page).to have_css 'a', text: File.basename(document2.file.url) 
  end

  scenario 'visitor sees a year folder for each publication year' do
    publication_2014 = Fabricate(:publication)
    publication_2013 = Fabricate(:publication)
    publication_2013.year = 2013
    publication_2014.year = 2014
    category = Fabricate(:category)
    category.name = "technical report"
    category.save
    publication_2014.category_id = category.id
    publication_2014.save
    publication_2013.category_id = category.id
    publication_2013.save
    visit series_path
    within('aside') { expect(page).to have_css 'a', text: publication_2014.year }
    within('aside') { expect(page).to have_css 'a', text: publication_2013.year }
  end

  scenario 'visitor views publication series archive' do
    publication = Fabricate(:publication)
    category = Fabricate(:category)
    category.name = "technical report"
    category.save
    publication.category_id = category.id
    publication.save
    visit series_path
    within('aside') { click_link publication.year }
    expect(page).to have_css 'h1', text: "POS+ Publication Series Archive"
    expect(page).to have_css 'h2', text: "#{publication.year}"
    expect(page).to have_css 'li', text: publication.body
  end

  scenario 'visitor should see publication for a given year in archive' do
    publication_2014 = Fabricate(:publication)
    publication_2013 = Fabricate(:publication)
    publication_2014.year = 2014
    publication_2013.year = 2013
    category = Fabricate(:category)
    category.name = "technical report"
    category.save
    publication_2014.category_id = category.id
    publication_2014.save
    publication_2013.category_id = category.id
    publication_2013.save
    visit series_path
    within('aside') { click_link publication_2014.year }
    expect(page).to have_css 'li', text: publication_2014.body
    expect(page).not_to have_css 'li', text: publication_2013.body
  end
end

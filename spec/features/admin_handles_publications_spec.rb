require 'spec_helper'

feature 'Admin interacts with publications' do
    background do
      @publication = Fabricate(:publication)  
      admin = Fabricate(:admin)
      sign_in(admin)
      visit admin_publications_path
    end
  scenario 'admin views publication' do
    expect(page).to have_css 'td', text: @publication.title
  end

  scenario 'admin clicks publication and views publication details' do
    click_link @publication.title
    expect(page).to have_css 'h1', text: @publication.title
  end

  scenario 'admin adds a new publication' do
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: @publication.title
      click_button 'Add Publication'
    }.to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "You successfully added a publication"
  end

  scenario 'admin should not be able to add publication without title' do
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: ""
      click_button 'Add Publication'
    }.not_to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "Title can't be blank"
  end

  scenario 'admin edits publication' do
    @publication.title = "edited title"
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set(@publication.title)
    click_button "Update Publication"
    expect(Publication.find(@publication.id).title).to eq("edited title")
    expect(page).to have_css 'p', text: "You successfully updated the publication"
  end

  scenario 'admin should not be able to update publications without title' do
    @publication.title = ""
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set(@publication.title)
    click_button "Update Publication"
    expect(Publication.find(@publication).title).not_to eq("")
    expect(page).to have_css 'p', text: "Title can't be blank"
  end

  scenario 'admin deletes publication' do
    expect{
      click_link "Delete"
    }.to change(Publication, :count).by(-1)
    expect(page).to have_css 'p', text: "You successfully deleted the publication"
  end
end

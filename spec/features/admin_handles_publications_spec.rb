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
    project = Fabricate(:research_project)
    @publication.research_projects << project
    document = Fabricate(:document)
    @publication.documents << document
    @publication.save
    click_link @publication.title
    expect(page).to have_css 'p', text: @publication.title
    expect(page).to have_css 'p', text: @publication.reference
    expect(page).to have_css 'a', text: project.title
    expect(page).to have_css 'a', text: File.basename(document.file.url)
  end

  scenario 'admin adds a new publication' do
    research_project = Fabricate(:research_project)
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: "new publication" 
      fill_in 'Reference', with: "some reference" 
      click_button 'Add Publication'
    }.to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "You successfully added a publication"
    visit admin_publication_path(@publication.id)
  end

  scenario 'admin should not be able to add publication without title and reference' do
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: "" 
      fill_in 'Reference', with: "" 
      click_button 'Add Publication'
    }.not_to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "Title can't be blank"
    expect(page).to have_css 'p', text: "Reference can't be blank"
  end


  scenario 'admin edits publication' do
    @research_project = Fabricate(:research_project)
    @publication.title = "edited title"
    @publication.reference = "edited reference"
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set(@publication.title)
    find("textarea[@id='publication_reference']").set(@publication.reference)
    click_button "Update Publication"
    expect(Publication.find(@publication).title).to eq("edited title")
    expect(Publication.find(@publication).reference).to eq("edited reference")
    expect(page).to have_css 'p', text: "You successfully updated the publication"
  end

  scenario 'admin should not be able to update publications without title and reference' do
    @publication.title = ""
    @publication.reference = ""
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set(@publication.title)
    find("textarea[@id='publication_reference']").set(@publication.reference)
    click_button "Update Publication"
    expect(Publication.find(@publication).title).not_to eq("")
    expect(Publication.find(@publication).reference).not_to eq("")
    expect(page).to have_css 'p', text: "Title can't be blank"
    expect(page).to have_css 'p', text: "Reference can't be blank"
  end

  scenario 'admin deletes publication' do
    expect{
      click_link "Delete"
    }.to change(Publication, :count).by(-1)
    expect(page).to have_css 'p', text: "You successfully deleted the publication"
    expect(current_path).to eq("/admin/publications")
  end

  scenario 'admin sees the research project the publication belongs to' do
    research_project = Fabricate(:research_project)
    @publication.research_projects << research_project
    @publication.save
    click_link @publication.title
    expect(page).to have_css 'li', text: research_project.title
  end

  scenario 'admin hides publication' do
    click_link "Hide" 
    @publication.reload
    expect(@publication.visible?).to be_false
  end
end

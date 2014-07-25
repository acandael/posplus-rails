require 'spec_helper'

feature 'Admin interacts with documents belonging to publication' do
  background do
    admin = Fabricate(:admin)
    sign_in(admin)
  end

  scenario 'admin sees data for publication' do
    @publication = Fabricate(:publication)
    data_document = Fabricate(:document)
    data_document2 = Fabricate(:document)
    @publication.documents << data_document
    @publication.documents << data_document2
    visit admin_publications_path
    find("a[href='/admin/publications/#{@publication.id}/documents']").click
    expect(page).to have_css 'h1', text: "Data"
    expect(page).to have_css 'a', text: File.basename(data_document.file.url) 
    expect(page).to have_css 'td', text: File.basename(data_document2.file.url)
  end

  scenario 'admin adds data document belonging to publication' do
    @publication = Fabricate(:publication)
    visit admin_publications_path
    find("a[href='/admin/publications/#{@publication.id}/documents']").click
    expect{
      find("input[@value='Add Document']").click
      attach_file('File', 'spec/support/uploads/vergadering.docx')
      click_button "Add Document"
    }.to change(Document, :count).by(1)
  end

  scenario 'admin deletes document' do
    publication = Fabricate(:publication)
    document = Fabricate(:document) 
    publication.documents << document
    publication.save
    visit admin_publication_documents_path(publication.id)
    expect{
      click_link "Delete"
    }.to change(Document, :count).by(-1)
    expect(page).to have_css 'p', text: "You successfully deleted the document"
  end

end

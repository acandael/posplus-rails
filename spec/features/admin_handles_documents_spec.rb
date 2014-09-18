require 'spec_helper'

feature 'Admin interacts with documents belonging to publication' do
  background do
    admin = Fabricate(:admin)
    sign_in(admin)
  end

  scenario 'admin clicks document link and views document details' do
    publication = Publication.create(title: "some publication title", body: "some publication reference", year: 2014)
    data_document = Fabricate(:document)
    data_document.description = "some description"
    data_document.save
    publication.documents << data_document

    visit admin_publication_documents_path(publication)
    click_link File.basename(data_document.file.url, ".*")

    expect(page).to have_css 'h3', text: File.basename(data_document.file.url, ".*")
    expect(page).to have_css 'a', text: File.basename(data_document.file.url) 
    expect(page).to have_css 'p', text: "some description" 
  end

  scenario 'admin sees data for publication' do
    @publication = Publication.create(title: "some publication title", body: "some publication reference", year: 2014)
    data_document = Fabricate(:document)
    data_document2 = Fabricate(:document)
    @publication.documents << data_document
    @publication.documents << data_document2
    visit admin_publications_path
    find("a[href='/admin/publications/#{@publication.id}/documents']").click
    expect(page).to have_css 'h1', text: "Data"
    expect(page).to have_css 'a', text: File.basename(data_document.file.url, ".*") 
    expect(page).to have_css 'a', text: File.basename(data_document2.file.url, ".*")
  end

  scenario 'admin adds data document belonging to publication' do
    @publication = Publication.create(title: "some publication title", body: "some publication reference", year: 2014)
    visit admin_publications_path
    find("a[href='/admin/publications/#{@publication.id}/documents']").click
    expect{
      find("input[@value='Add Document']").click
      attach_file('File', 'spec/support/uploads/vergadering.docx')
      click_button "Add Document"
    }.to change(Document, :count).by(1)
  end

  scenario 'admin edits data document belonging to publication' do
    publication = Publication.create(title: "some publication title", body: "some publication reference", year: 2014)
    data_document = Fabricate(:document)
    data_document.description = "some description"
    data_document.save
    publication.documents << data_document

    visit admin_publication_documents_path(publication)
    find("a[href='/admin/publications/#{publication.id}/documents/#{data_document.id}/edit']").click
    attach_file 'File', "spec/support/uploads/vergadering.docx"
    find("input[@id='document_description']").set("some other description")
    click_button "Update Document"

    data_document.reload
    expect(Document.find(data_document).description).to eq("some other description")
    expect(page).to have_css 'p', text: "You successfully updated the document"
    expect(Document.find(data_document).file.url).to eq("/uploads/document/file/vergadering.docx")
  end

  scenario 'admin deletes document' do
    publication = Publication.create(title: "some publication title", body: "some publication reference", year: 2014)
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

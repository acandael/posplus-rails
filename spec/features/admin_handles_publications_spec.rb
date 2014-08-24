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
    category = Category.create(name: "working_paper")
    @publication.category = category 
    @publication.series = 1
    document = Fabricate(:document)
    @publication.documents << document
    @publication.save
    click_link @publication.title
    expect(page).to have_css 'p', text: @publication.title
    expect(page).to have_css 'p', text: @publication.body
    expect(page).to have_css 'p', text: @publication.year
    expect(page).to have_css 'p', text: "number #{@publication.series}"
    expect(page).to have_css 'a', text: project.title
    expect(page).to have_css 'a', text: File.basename(document.file.url)
    expect(page).to have_css 'p', text: @publication.category.name
  end

  scenario 'admin adds a new publication' do
    research_project1 = Fabricate(:research_project)
    research_project2 = Fabricate(:research_project)
    category1 = Category.create(name: "working paper")
    category2 = Category.create(name: "technical report")
    researcher1 = Fabricate(:researcher)
    researcher2 = Fabricate(:researcher)
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: "new publication" 
      fill_in 'Year', with: "2013"
      select "working paper", from: "Category" 
      fill_in 'Series', with: 1
      fill_in 'Body', with: "some reference" 
      check researcher1.fullname
      check researcher2.fullname
      check research_project1.title
      check research_project2.title
      click_button 'Add Publication'
    }.to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "You successfully added a publication"
    expect((Publication.last).title).to eq("new publication")
    expect((Publication.last).year).to eq(2013)
    expect((Publication.last).series).to eq(1)
    expect((Publication.last).category.name).to eq("working paper")
    expect((Publication.last).researchers.size).to eq(2)
    expect((Publication.last).research_projects.size).to eq(2)
    expect((Publication.last).body).to eq("some reference")
  end

  scenario 'admin should not be able to add publication without title and reference' do
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: "" 
      fill_in 'Body', with: "" 
      click_button 'Add Publication'
    }.not_to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "Title can't be blank"
    expect(page).to have_css 'p', text: "Body can't be blank"
  end

  scenario 'admin should not be able to add publication with publication year' do
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: "new publication" 
      fill_in 'Year', with: ""
      fill_in 'Body', with: "some description" 
      click_button 'Add Publication'
    }.not_to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "Year can't be blank"
  end

  scenario 'admin should not be able to insert series with non-numerical value' do
    expect{
      find("input[@value='Add Publication']").click
      fill_in 'Title', with: "new publication" 
      fill_in 'Year', with: "2014"
      fill_in 'Series', with: "hello"
      fill_in 'Body', with: "some description" 
      click_button 'Add Publication'
    }.not_to change(Publication, :count).by(1)
    expect(page).to have_css 'p', text: "Series is not a number"
  end


  scenario 'admin edits publication' do
    @research_project = Fabricate(:research_project)
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set("edited title")
    find("input[@id='publication_year']").set(2013)
    find("input[@id='publication_series']").set(1)
    find("textarea[@id='publication_body']").set("edited reference")
    click_button "Update Publication"
    expect(Publication.find(@publication).title).to eq("edited title")
    expect(Publication.find(@publication).year).to eq(2013)
    expect(Publication.find(@publication).series).to eq(1)
    expect(Publication.find(@publication).body).to eq("edited reference")
    expect(page).to have_css 'p', text: "You successfully updated the publication"
  end

  scenario 'admin should not be able to update publications without title and reference' do
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set("")
    find("textarea[@id='publication_body']").set("")
    click_button "Update Publication"
    expect(Publication.find(@publication).title).not_to eq("")
    expect(Publication.find(@publication).body).not_to eq("")
    expect(page).to have_css 'p', text: "Title can't be blank"
    expect(page).to have_css 'p', text: "Body can't be blank"
  end

  scenario 'admin should not be able to edit publication without a year' do
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set("edited title")
    find("input[@id='publication_year']").set(nil)
    find("textarea[@id='publication_body']").set("edited reference")
    click_button "Update Publication"
    expect(Publication.find(@publication).title).not_to eq("edited title")
    expect(Publication.find(@publication).year).not_to eq(nil)
    expect(Publication.find(@publication).body).not_to eq("edited reference")
    expect(page).to have_css 'p', text: "Year can't be blank"
  end

  scenario 'admin should enter numeric value for year' do
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set("edited title")
    find("input[@id='publication_year']").set('hello baby')
    find("textarea[@id='publication_body']").set("edited reference")
    click_button "Update Publication"
    expect(Publication.find(@publication).title).not_to eq("edited title")
    expect(Publication.find(@publication).year).not_to eq('hello baby')
    expect(Publication.find(@publication).body).not_to eq("edited reference")
    expect(page).to have_css 'p', text: "Year is not a number"
  end

  scenario 'admin should enter numeric value for series' do
    find("a[href='/admin/publications/#{@publication.id}/edit']").click
    find("input[@id='publication_title']").set("edited title")
    find("input[@id='publication_year']").set(2012)
    find("input[@id='publication_series']").set('hello')
    find("textarea[@id='publication_body']").set("edited reference")
    click_button "Update Publication"
    expect(Publication.find(@publication).title).not_to eq("edited title")
    expect(Publication.find(@publication).year).not_to eq(2012)
    expect(Publication.find(@publication).body).not_to eq("edited reference")
    expect(Publication.find(@publication).series).not_to eq('hello')
    expect(page).to have_css 'p', text: "Series is not a number"
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
    category = Fabricate(:category)
    @publication.category_id = category.id
    @publication.save
    click_link @publication.title
    expect(page).to have_css 'li', text: research_project.title
  end

  scenario 'admin sees no research projects assigned when no research project' do
    research_project = Fabricate(:research_project)
    category = Fabricate(:category)
    @publication.category_id = category.id
    @publication.save
    click_link @publication.title
    expect(page).to have_css 'li', text: "no research projects assigned" 
  end

  scenario 'admin hides publication' do
    click_link "Hide" 
    expect(page).to have_css 'p', text: "The publication is now hidden"
    @publication.reload
    expect(@publication.visible?).to be_false
  end

  scenario 'Admin shows publication' do
    @publication.visible = false
    @publication.save
    visit admin_publications_path
    click_link "Show"
    expect(page).to have_css 'p', text: "The publication is now visible"
    @publication.reload
    expect(@publication.visible).to be_true 
  end

  scenario 'Admin sees researchers for publication' do
    researcher1 = Fabricate(:researcher)
    researcher2 = Fabricate(:researcher)
    category = Fabricate(:category)
    @publication.category_id = category.id
    @publication.researchers << researcher1
    @publication.researchers << researcher2
    @publication.save
    click_link @publication.title
    expect(page).to have_css 'li', text: researcher1.fullname
    expect(page).to have_css 'li', text: researcher2.fullname
  end

  scenario 'Admin sees no researchers assigned when no researchers' do
    category = Fabricate(:category)
    @publication.category_id = category.id
    @publication.save
    click_link @publication.title
    expect(page).to have_css 'li', text: "no researchers assigned"
  end
end

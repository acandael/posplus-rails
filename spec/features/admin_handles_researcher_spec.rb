require 'spec_helper'

feature "Admin interacts with researcher" do
  background do
    @researcher = Fabricate(:researcher)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_researchers_path
  end

  scenario "Admin views researchers" do
    expect(page).to have_content @researcher.name
  end

  scenario "Admin clicks researcher link and views researcher details" do
    project = Fabricate(:research_project)
    @researcher.research_projects << project
    course = Fabricate(:course)
    @researcher.courses << course
    @researcher.save

    click_link @researcher.name

    expect(page).to have_css 'h1', text: @researcher.name
    expect(page).to have_css 'p', text: @researcher.bio
    expect(page).to have_css 'a', text: @researcher.email
    page.should have_xpath("//img[@src=\"/uploads/researcher/image/#{File.basename(@researcher.image.url)}\"]")
    expect(page).to have_css 'a', text: course.title
    expect(page).to have_css 'a', text: project.title
  end

  scenario "Admin adds a researcher" do
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'Name', with: "some name" 
      fill_in 'Bio', with: "this is the bio" 
      fill_in 'Email', with: "researcher@example.com" 
      attach_file 'Image', "spec/support/uploads/monk_large.jpg"
      click_button "Add Researcher"
    }.to change(Researcher, :count).by(1)
    expect((Researcher.last).name).to eq("some name")
    expect((Researcher.last).bio).to eq("this is the bio")
    expect((Researcher.last).email).to eq("researcher@example.com")
    expect((Researcher.last).image.url).to eq("/uploads/researcher/image/monk_large.jpg")
    expect(page).to have_css 'p', text: "You successfully added a new researcher"
  end

  scenario 'Admin should not be able to add research project without name' do
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'Name', with: ""
      fill_in 'Bio', with: "this is the bio"
      click_button "Add Researcher"
    }.not_to change(Researcher, :count).by(1)
    expect(page).to have_css 'p', text: "Name can't be blank" 
  end

  scenario 'Admin should not be able to add research project without bio' do
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'Name', with: "John Doe"
      fill_in 'Bio', with: ""
      click_button "Add Researcher"
    }.not_to change(Researcher, :count).by(1)
    expect(page).to have_css 'p', text: "Bio can't be blank" 
  end

  scenario 'Admin should not be able to add a researcher if the name already exists' do
    researcher2 = Fabricate(:researcher)
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'Name', with: @researcher.name 
      fill_in 'Bio', with: "some bio" 
      click_button "Add Researcher"
    }.not_to change(Researcher, :count).by(1)
    expect(page).to have_content "Name has already been taken"
  end

  scenario 'Admin edits researcher' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_name']").set("John Doe")
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    click_button "Update Researcher"
    @researcher.reload
    expect(@researcher.name).to eq("John Doe")
    expect(@researcher.bio).to eq("John Doe's bio")
    expect(page).to have_content "you successfully updated the researcher"
  end

  scenario 'Admin should not be able to update researcher without name' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_name']").set("")
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    click_button "Update Researcher"
    expect(page).to have_content "Name can't be blank"
    expect(@researcher.name).not_to eq("")
    expect(@researcher.bio).not_to eq("John Doe's bio")
  end

  scenario 'Admin should not be able to update researcher without email' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_name']").set("John Doe")
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    find("input[@id='researcher_email']").set("")
    click_button "Update Researcher"
    expect(page).to have_content "Email can't be blank"
    expect(@researcher.name).not_to eq("John Doe")
    expect(@researcher.bio).not_to eq("John Doe's bio")
    expect(@researcher.email).not_to eq("")
  end

  scenario 'Admin should not be able to give duplicate name while editing' do
    researcher2 = Fabricate(:researcher)
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_name']").set(researcher2.name)
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    find("input[@id='researcher_email']").set("john.doe@example.com")
    click_button "Update Researcher"
    expect(page).to have_css 'p', text: "Name has already been taken"
    expect(@researcher.name).not_to eq(researcher2.name)
    expect(@researcher.bio).not_to eq("John Doe's bio")
    expect(@researcher.email).not_to eq("john.doe@example.com")
  end

  scenario 'Admin deletes researcher' do
    expect{
      click_link "Delete"
    }.to change(Researcher, :count).by(-1)
    expect(page).to have_css 'p', text: "You successfully removed the researcher"
    expect(current_path).to eq("/admin/researchers")
  end

  scenario 'Admin sees research projects for researcher' do
    research_project1 = Fabricate(:research_project)
    @researcher.research_projects << research_project1 
    click_link @researcher.name
    expect(page).to have_css 'li', text: research_project1.title
  end

  scenario 'Admin sees courses for researcher' do
    course = Fabricate(:course)
    @researcher.courses << course
    click_link @researcher.name
    expect(page).to have_css 'li', text: course.title
  end

  scenario 'Admin hides researcher' do
    click_link "Hide"
    @researcher.reload
    expect(@researcher.visible).to be_false
    expect(page).to have_css 'a', text: "Show"
    expect(page).to have_css 'p', text: "The researcher was successfully updated!"
  end
end

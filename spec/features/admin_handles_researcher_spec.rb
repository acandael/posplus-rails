require 'spec_helper'

feature "Admin interacts with researcher" do
  background do
    @researcher = Fabricate(:researcher)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_researchers_path
  end

  scenario "Admin clicks researcher link and views researcher details" do
    project = Fabricate(:research_project)
    @researcher.research_projects << project
    course = Fabricate(:course)
    @researcher.courses << course
    @researcher.save

    click_link @researcher.fullname

    expect(page).to have_css 'h1', text: @researcher.fullname
    expect(page).to have_css 'p', text: @researcher.bio
    expect(page).to have_css 'a', text: @researcher.email
    page.should have_xpath("//img[@src=\"/uploads/researcher/image/#{@researcher.id}/#{File.basename(@researcher.image.url)}\"]")
    expect(page).to have_css 'a', text: course.title
    expect(page).to have_css 'a', text: project.title
  end

  scenario "Admin adds a researcher" do
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'First name', with: "John" 
      fill_in 'Last name', with: "Doe"
      fill_in 'Bio', with: "this is the bio" 
      fill_in 'Email', with: "researcher@example.com" 
      attach_file 'Image', "spec/support/uploads/monk_large.jpg"
      click_button "Add Researcher"
    }.to change(Researcher, :count).by(1)
    expect((Researcher.last).first_name).to eq("John")
    expect((Researcher.last).last_name).to eq("Doe")
    expect((Researcher.last).bio).to eq("this is the bio")
    expect((Researcher.last).email).to eq("researcher@example.com")
    expect((Researcher.last).image.url).to eq("/uploads/researcher/image/#{Researcher.last.id}/monk_large.jpg")
    expect(page).to have_css 'p', text: "You successfully added a new researcher"
  end

  scenario 'Admin should not be able to add research project without bio' do
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'First name', with: "John"
      fill_in 'Last name', with: "Doe"
      fill_in 'Bio', with: ""
      click_button "Add Researcher"
    }.not_to change(Researcher, :count).by(1)
    expect(page).to have_css 'p', text: "Bio can't be blank" 
  end

  scenario 'Admin should not be able to add a researcher if the name already exists' do
    researcher2 = Fabricate(:researcher)
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'First name', with: @researcher.first_name 
      fill_in 'Last name', with: @researcher.last_name 
      fill_in 'Bio', with: "some bio" 
      fill_in 'Email', with: "john.doe@example.com" 
      click_button "Add Researcher"
    }.not_to change(Researcher, :count).by(1)
    expect(page).to have_content "Last name has already been taken"
  end

  scenario 'Admin should not be able to add title longer then 30 characters' do
    expect{
      find("input[@value='Add Researcher']").click
      fill_in 'First name', with: "Bram" 
      fill_in 'Last name', with: "Moolenaar"
      fill_in 'Title', with: "this is more than 30 characters"
      fill_in 'Bio', with: "some bio" 
      fill_in 'Email', with: "john.doe@example.com" 
      click_button "Add Researcher"
    }.not_to change(Researcher, :count).by(1)
    expect(page).to have_content "Title is too long (maximum is 30 characters)"
  end

  scenario 'Admin edits researcher' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_first_name']").set("John")
    find("input[@id='researcher_last_name']").set("Doe")
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    click_button "Update Researcher"
    @researcher.reload
    expect(@researcher.first_name).to eq("John")
    expect(@researcher.last_name).to eq("Doe")
    expect(@researcher.bio).to eq("John Doe's bio")
    expect(page).to have_content "you successfully updated the researcher"
  end

  scenario 'Admin should not be able to update researcher without first name' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_first_name']").set("")
    find("input[@id='researcher_last_name']").set("Doe")
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    click_button "Update Researcher"
    expect(page).to have_content "First name can't be blank"
    expect(@researcher.first_name).not_to eq("")
    expect(@researcher.bio).not_to eq("John Doe's bio")
  end

  scenario 'Admin should not be able to update researcher without last name' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_first_name']").set("John")
    find("input[@id='researcher_last_name']").set("")
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    click_button "Update Researcher"
    expect(page).to have_content "Last name can't be blank"
    expect(@researcher.last_name).not_to eq("")
    expect(@researcher.bio).not_to eq("John Doe's bio")
  end

  scenario 'Admin should not be able to update researcher without email' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_first_name']").set("John")
    find("input[@id='researcher_last_name']").set("Doe")
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    find("input[@id='researcher_email']").set("")
    click_button "Update Researcher"
    expect(page).to have_content "Email can't be blank"
    expect(@researcher.email).not_to eq("")
  end

  scenario 'Admin should not be able to give duplicate name while editing' do
    researcher2 = Fabricate(:researcher)
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    find("input[@id='researcher_first_name']").set(researcher2.first_name)
    find("input[@id='researcher_last_name']").set(researcher2.last_name)
    find("textarea[@id='researcher_bio']").set("John Doe's bio")
    find("input[@id='researcher_email']").set("john.doe@example.com")
    click_button "Update Researcher"
    expect(page).to have_css 'p', text: "Last name has already been taken"
    expect(@researcher.first_name).not_to eq(researcher2.first_name)
    expect(@researcher.last_name).not_to eq(researcher2.last_name)
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
    click_link @researcher.fullname
    expect(page).to have_css 'li', text: research_project1.title
  end

  scenario 'Admin sees courses for researcher' do
    course = Fabricate(:course)
    @researcher.courses << course
    click_link @researcher.fullname
    expect(page).to have_css 'li', text: course.title
  end

  scenario 'Admin hides researcher' do
    click_link "Hide"
    expect(page).to have_css 'p', text: "The researcher #{ @researcher.fullname } is now hidden"
    @researcher.reload
    expect(@researcher.visible).to be_false
  end

  scenario 'Admin shows researcher' do
    @researcher.visible = false
    @researcher.save
    visit admin_researchers_path
    click_link "Show"
    expect(page).to have_css 'p', text: "The researcher #{ @researcher.fullname } is now visible"
    @researcher.reload
    expect(@researcher.visible).to be_true 
  end

  scenario 'Admin changes researcher from current to past' do
    find("a[href='/admin/researchers/#{@researcher.id}/edit']").click 
    uncheck 'Active'
    click_button "Update Researcher"
    @researcher.reload 
    expect(@researcher.active).to be_false
  end
end

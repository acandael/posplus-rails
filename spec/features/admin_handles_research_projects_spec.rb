require 'spec_helper'
require 'carrierwave/test/matchers'

feature "Admin interacts with research projects" do
  background do
    @research_project = Fabricate(:research_project)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_research_projects_path    
  end
  scenario "Admin views research projects" do
    expect(page).to have_content @research_project.title 
  end

  scenario "Admin clicks research project link and views research project details" do
    click_link @research_project.title
    expect(page).to have_css 'h1', text: @research_project.title
    expect(page).to have_css 'div', text: @research_project.body
    page.should have_xpath("//img[@src=\"/uploads/research_project/image/#{File.basename(@research_project.image.url)}\"]")
  end

  scenario 'Admin adds a research project' do
    expect{
    find("input[@value='Add Research Project']").click
    fill_in 'Title', with: "new research project" 
    fill_in 'Body', with: "description for research project" 
    attach_file 'Image', "spec/support/uploads/monk_large.jpg"
    click_button "Add Research Project"
    }.to change(ResearchProject, :count).by(1)

    expect(page).to have_css 'a', text: "new research project" 
    expect((ResearchProject.last).image.url).to eq("/uploads/research_project/image/monk_large.jpg")
    expect(page).to have_content "you successfully added a new research project"
  end

  scenario 'Admin should not be able to add research project without title and body' do
    expect{
      find("input[@value='Add Research Project']").click
      fill_in 'Title', with: "" 
      fill_in 'Body', with: ""
      click_button "Add Research Project"
    }.not_to change(ResearchProject, :count).by(1)
    expect(page).to have_css 'h1', text: "Add new research project"
    expect(page).to have_css 'p', text: "there was a problem, the research project was not added"
  end

  scenario 'Admin edits research project' do
    @research_project.title = "this is the edited title"
    find("a[href='/admin/research_projects/#{@research_project.id}/edit']").click 
    find("input[@id='research_project_title']").set(@research_project.title)
    attach_file 'Image', "spec/support/uploads/monk_large.jpg"
    click_button "Update Research Project"
    expect(page).to have_content "this is the edited title"
    expect((ResearchProject.last).image.url).to eq("/uploads/research_project/image/monk_large.jpg")
    expect(page).to have_content "you successfully updated the research project"
  end

  scenario 'Admin should not be able to update research project without title or body' do
    @research_project.title = "this is the edited title"
    @research_project.body = ""
    find("a[href='/admin/research_projects/#{@research_project.id}/edit']").click 
    find("input[@id='research_project_title']").set(@research_project.title)
    find("textarea[@id='research_project_body']").set(@research_project.body)
    click_button "Update Research Project"
    expect(ResearchProject.find(@research_project.id).title).not_to eq("this is the edited title")
    expect(page).to have_content "there was a problem, the research project could not be updated"
  end

  scenario "Admin deletes research project" do
    expect{
      click_link "Delete"
    }.to change(ResearchProject, :count).by(-1)
    expect(page).to have_content "you successfully removed the research project"
  end

  scenario "Dependent associations are destroyed when admin deletes research project" do
    research_theme_1 = Fabricate(:research_theme)
    research_theme_2 = Fabricate(:research_theme)

    @research_project.research_themes << research_theme_1
    @research_project.research_themes << research_theme_2

    themes = @research_project.research_themes

    click_link "Delete"

    themes.each do |theme|
        theme.research_projects.should_not include(@research_project)
    end
  end

  scenario "Admin sees research themes for research project" do
    research_theme_1 = Fabricate(:research_theme)
    research_theme_2 = Fabricate(:research_theme)
    @research_project.research_themes << research_theme_1
    @research_project.research_themes << research_theme_2
    click_link @research_project.title
    expect(page).to have_css 'li', text: research_theme_1.title
    expect(page).to have_css 'li', text: research_theme_2.title
  end

  scenario "Admin sees researchers for research project" do
    researcher1 = Fabricate(:researcher)
    researcher2 = Fabricate(:researcher)
    @research_project.researchers << researcher1
    @research_project.researchers << researcher2
    click_link @research_project.title
    expect(page).to have_css 'li', text: researcher1.name
    expect(page).to have_css 'li', text: researcher2.name
  end

  scenario "Admin sees publications for research project" do
    publication1 = Fabricate(:publication)
    publication2 = Fabricate(:publication)
    @research_project.publications << publication1
    @research_project.publications << publication2
    click_link @research_project.title
    expect(page).to have_css 'li', text: publication1.title
    expect(page).to have_css 'li', text: publication2.title
  end

  scenario "Admin closes research project" do
    click_link "Close"
    @research_project.reload
    expect(@research_project.active).to be_false
    expect(page).to have_css 'a', text: 'Open'
  end
end

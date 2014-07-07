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
  end

  scenario 'Admin adds a research project' do
    expect{
    click_link "Add Research Project"
    fill_in 'Title', with: @research_project.title 
    fill_in 'Body', with: @research_project.body 
    attach_file 'Image', "spec/support/uploads/monk_large.jpg"
    click_button "Add Research Project"
    }.to change(ResearchProject, :count).by(1)

    expect(page).to have_content @research_project.title 
    expect(page).to have_content "you successfully added a new research project"

    visit admin_research_project_path @research_project.id
    expect(page).to have_content "monk_large.jpg"
  end

  scenario 'Admin should not be able to add research project without title and body' do
    expect{
      click_link "Add Research Project"
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
    click_button "Update Research Project"
    expect(page).to have_content "this is the edited title"
    expect(page).to have_content "you successfully updated the research project"
  end

  scenario 'Admin should not be able to update research project without title or body' do
    @research_project.title = "this is the edited title"
    @research_project.body = ""
    find("a[href='/admin/research_projects/#{@research_project.id}/edit']").click 
    find("input[@id='research_project_title']").set(@research_project.title)
    find("textarea[@id='research_project_body']").set(@research_project.body)
    click_button "Update Research Project"
    expect(page).not_to have_content "this is the edited title"
    expect(page).to have_content "there was a problem, the research project could not be updated"
  end

  scenario "Admin deletes research project" do
    expect{
      click_link "Delete"
    }.to change(ResearchProject, :count).by(-1)
    expect(page).to have_content "you successfully removed the research project"
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

  scenario "Admin adds research themes to research project" do
    research_theme_1 = Fabricate(:research_theme)
    research_theme_2 = Fabricate(:research_theme)
    research_theme_3 = Fabricate(:research_theme)

    click_link "Add Research Project"


    expect(page).to have_css 'label', text: research_theme_1.title
    expect(page).to have_css 'label', text: research_theme_2.title
    expect(page).to have_css 'label', text: research_theme_3.title

    check "research_project_research_theme_ids_1"
    check "research_project_research_theme_ids_2"


    click_button "Add Research Project"

    @research_project.reload
    expect(@research_project.research_themes.count).to eq(2)
  end
end

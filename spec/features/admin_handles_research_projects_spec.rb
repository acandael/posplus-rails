require 'spec_helper'

feature "Admin interacts with research projects" do
  scenario "Admin views research projects" do
    research_project = ResearchProject.new(title: "research project 1", body: "this is the content")
    research_project.save
    visit admin_research_projects_path    
    expect(page).to have_content research_project.title 
  end

  scenario "Admin clicks research project link and views research project details" do
    research_project = ResearchProject.new(title: "research project 1", body: "this is the content")
    research_project.save
    visit admin_research_projects_path    
    click_link research_project.title
    expect(page).to have_css 'h1', text: research_project.title
    expect(page).to have_css 'div', text: research_project.body
  end

  scenario 'Admin adds a research project' do
    expect{
    visit admin_research_projects_path    
    click_link "Add Research Project"
    fill_in 'Title', with: "research project 1"
    fill_in 'Body', with: "this is the body"
    click_button "Add Research Project"
    }.to change(ResearchProject, :count).by(1)

    expect(page).to have_content "research project 1"
    expect(page).to have_content "you successfully added a new research project"
  end
end

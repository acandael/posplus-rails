require 'spec_helper'

feature "Admin interacts with research projects" do
  scenario "Admin views research projects" do
    research_project = ResearchProject.new(title: "research project 1", body: "this is the content")
    research_project.save
    visit admin_research_projects_path    
    expect(page).to have_content research_project.title 
  end
end

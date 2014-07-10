require 'spec_helper'

feature 'Visitor interacts with research page' do
  scenario 'and sees research themes' do
    @research_theme = Fabricate(:research_theme)
    visit research_index_path
    expect(page).to have_css 'h2', text: @research_theme.title
    expect(page).to have_css 'p', text: @research_theme.description
  end

  scenario 'clicks projects link and sees projects' do
    research_theme = Fabricate(:research_theme)
    research_project = Fabricate(:research_project)
    research_theme.research_projects << research_project
    visit research_index_path
    click_link 'Go to projects'
    expect(page).to have_css 'h1', text: "Projects"
    expect(page).to have_css 'h2', text: research_theme.title
    expect(page).to have_css 'p', text: research_theme.description
    expect(page).to have_css 'a', text: research_project.title
    expect(page).to have_css 'p', text: research_project.body
  end

  scenario 'clicks project link and sees research project details' do
    research_theme = Fabricate(:research_theme)
    research_project = Fabricate(:research_project)
    researcher = Fabricate(:researcher)
    research_project.researchers << researcher
    research_theme.research_projects << research_project
    visit research_index_path
    click_link 'Go to projects'
    find("a[href='/research_projects/#{research_project.id}']").click 
    expect(page).to have_css 'h1', text: research_project.title
    expect(page).to have_css 'p', text: research_project.body
    expect(page).to have_css 'a', text: researcher.name

  end
end
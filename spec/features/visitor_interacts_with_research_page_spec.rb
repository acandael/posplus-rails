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
    research_project.save
    visit research_index_path
    click_link 'Go to projects'
    within("section.projects") { expect(page).to have_css 'h2', text: "Projects" }
    within("div.project") { expect(page).to have_css 'a', text: research_project.title }
    within("div.theme") { expect(page).to have_css 'p', text: research_theme.description }
    expect(page).to have_css 'a', text: research_project.title
    expect(page).to have_css 'p', text: research_project.body
    within("aside") { expect(page).to have_css 'a', text: "Data" }
  end

  scenario 'clicks project link and sees research project details' do
    research_theme = Fabricate(:research_theme)
    research_project = Fabricate(:research_project)
    researcher = Fabricate(:researcher)
    publication = Fabricate(:publication)
    research_project.researchers << researcher
    research_project.publications << publication
    research_theme.research_projects << research_project
    visit research_index_path
    click_link 'Go to projects'
    find("a[href='/research_projects/#{research_project.id}']").click 
    expect(page).to have_css 'h1', text: research_project.title
    expect(page).to have_css 'p', text: research_project.body
    expect(page).to have_css 'a', text: researcher.name
    expect(page).to have_css 'li', text: publication.reference
    page.should have_xpath("//img[@src=\"/uploads/research_project/image/#{File.basename(research_project.image.url)}\"]")
  end

  scenario 'clicks project link and does not see hidden publications belonging to research project' do
    research_theme = Fabricate(:research_theme)
    research_project = Fabricate(:research_project)
    researcher = Fabricate(:researcher)
    publication = Fabricate(:publication)
    publication.visible = false
    publication.save
    research_project.researchers << researcher
    research_project.publications << publication
    research_theme.research_projects << research_project
    visit research_index_path
    click_link 'Go to projects'
    find("a[href='/research_projects/#{research_project.id}']").click 
    expect(page).not_to have_css 'li', text: publication.reference 
  end
end

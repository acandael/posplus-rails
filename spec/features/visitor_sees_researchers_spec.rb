require 'spec_helper'

feature "Visitor interacts with people page and" do
  background do
    @researcher = Fabricate(:researcher)
  end
  scenario "sees researchers" do
    visit people_path
    expect(page).to have_css 'h1', text: "People"
    expect(page).to have_css 'h5', text: @researcher.fullname 
    expect(page).to have_css 'p', text: @researcher.title
    page.should have_xpath("//img[@src=\"/uploads/researcher/image/#{@researcher.id}/#{File.basename(@researcher.image.url(:thumb))}\"]")
  end

  scenario "does not see hidden researcher" do
    @researcher.visible = false
    @researcher.save
    visit people_path
    expect(page).not_to have_css 'h5', text:@researcher.fullname
  end


  scenario "visitor clicks researcher and sees researcher details" do
    publication = Fabricate(:publication)
    publication.researchers << @researcher
    course = Fabricate(:course)
    @researcher.courses << course
    project = Fabricate(:research_project)
    @researcher.research_projects << project
    @researcher.phone = "+32 (0)9 264 67 98"
    @researcher.address = "Korte Meer 3, 9000 Ghent, Belgium"
    @researcher.bibliography = "http://biblio.ugent.be"
    @researcher.save

    visit people_path
    find("h5 a[href='/people/#{@researcher.id}']").click

    expect(page).to have_css 'h1', text: @researcher.fullname
    page.should have_xpath("//img[@src=\"/uploads/researcher/image/#{@researcher.id}/#{File.basename(@researcher.image.url)}\"]")
    expect(page).to have_css 'li', text: course.title
    expect(page).to have_css 'p', text: publication.body
    expect(page).to have_css 'a', text: project.title
    expect(page).to have_css 'a', text: @researcher.email
    expect(page).to have_css 'p', text: "+32 (0)9 264 67 98"
    expect(page).to have_css 'p', text: "Korte Meer 3, 9000 Ghent, Belgium"
    expect(page).to have_css 'a', text: "http://biblio.ugent.be"
  end

  scenario "visitor clicks research project link on researcher details page and goes to research project page" do
    project = Fabricate(:research_project)
    @researcher.research_projects << project
    @researcher.save

    visit people_path

    find("h5 a[href='/people/#{@researcher.id}']").click
    find("a[href='/research_projects/#{project.id}']").click
    expect(current_path).to eq("/research_projects/#{project.id}")
  end
end

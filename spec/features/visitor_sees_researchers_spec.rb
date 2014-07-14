require 'spec_helper'

feature "Visitor interacts with people page and" do
  background do
    @researcher = Fabricate(:researcher)
  end
  scenario "sees researchers" do
    visit people_path
    expect(page).to have_css 'h1', text: "People"
    expect(page).to have_css 'h5', text: @researcher.name 
    expect(page).to have_css 'p', text: @researcher.title
  end

  scenario "visitor clicks researcher and sees researcher details" do
    visit people_path
    find("a[href='/people/#{@researcher.id}']").click
    expect(page).to have_css 'h1', text: @researcher.name
    page.should have_xpath("//img[@src=\"/uploads/researcher/image/#{File.basename(@researcher.image.url)}\"]")
  end

  scenario "visitor clicks researcher and sees courses for researcher" do
    course = Fabricate(:course)
    @researcher.courses << course
    @researcher.image = "spec/uploads/monk.jpg"
    visit people_path
    find("a[href='/people/#{@researcher.id}']").click
    expect(page).to have_css 'li', text: course.title
  end
end

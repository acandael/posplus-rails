require 'spec_helper'

feature "Admin interacts with courses" do
  background do
    @course = Fabricate(:course)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_courses_path
  end

  scenario "admin views courses" do
    expect(page).to have_content @course.title
  end

  scenario "admin clicks course link and views course details" do
    click_link @course.title
    expect(page).to have_css 'h1', text: @course.title
  end

  scenario "admin adds a course" do
    course2 = Fabricate(:course)
    expect{
      find("input[@value='Add Course']").click
      fill_in 'Title', with: course2.title
      click_button "Add Course"
    }.to change(Course, :count).by(1)

    expect(page).to have_css 'a', text: course2.title
    expect(page).to have_css 'p', text: "you successfully added a new course"
  end

  scenario "admin should not be able to add course without title" do
    expect{
      find("input[@value='Add Course']").click
      fill_in 'Title', with: "" 
      click_button "Add Course"
    }.not_to change(Course, :count).by(1)
    expect(page).to have_css 'p', text: "there was a problem, the course was not added!"
  end

  scenario 'admin edits course' do
    @course.title = "this is the edited title"
    find("a[href='/admin/courses/#{@course.id}/edit']").click 
    find("input[@id='course_title']").set(@course.title)
    click_button "Update Course"
    expect(page).to have_css 'a', text: "this is the edited title"
    expect(page).to have_css 'p', text: "You successfully updated the course"
  end

  scenario 'an admin should not be able to update the course without title' do
    @course.title = ""
    find("a[href='/admin/courses/#{@course.id}/edit']").click 
    find("input[@id='course_title']").set(@course.title)
    click_button "Update Course"
    expect(Course.find(@course.id).title).not_to eq("")
    expect(page).to have_css 'p', text: "there was a problem, the course could not be updated"
  end

  scenario 'an admin deletes a course' do
    expect{
      click_link "Delete"
    }.to change(Course, :count).by(-1)
    expect(page).to have_css 'p', text: "you successfully deleted a course"
  end

  scenario 'an admin sees researchers belonging to course' do
    researcher = Fabricate(:researcher)
    @course.researchers << researcher
    click_link @course.title
    expect(page).to have_css 'li', text: researcher.name 
  end
end

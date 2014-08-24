require 'spec_helper'

feature "Admin interacts with courses" do
  background do
    @course = Fabricate(:course)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_courses_path
  end

  scenario "admin views courses" do
    within("table.table-borders") { expect(page).to have_css 'a', text: @course.title }
  end

  scenario "admin clicks course link and views course details" do
    teacher = Fabricate(:researcher)
    @course.researchers << teacher
    @course.save

    click_link @course.title

    expect(page).to have_css 'h1', text: @course.title
    expect(page).to have_css 'a', text: teacher.fullname
  end

  scenario "admin adds a course" do
    expect{
      find("input[@value='Add Course']").click
      fill_in 'Title', with: "new course" 
      click_button "Add Course"
    }.to change(Course, :count).by(1)

    expect(page).to have_css 'a', text: "new course" 
    expect(page).to have_css 'p', text: "you successfully added a new course"
  end

  scenario "admin should not be able to add course without title" do
    expect{
      find("input[@value='Add Course']").click
      fill_in 'Title', with: "" 
      click_button "Add Course"
    }.not_to change(Course, :count).by(1)
    expect(page).to have_css 'p', text: "Title can't be blank"
    expect((Course.last).title).not_to eq("")
  end

  scenario "admin should not be able to add duplicate course title" do
    expect{
      find("input[@value='Add Course']").click
      fill_in 'Title', with: @course.title 
      click_button "Add Course"
    }.not_to change(Course, :count).by(1)
    expect(page).to have_css 'p', text: "Title has already been taken"
  end

  scenario 'admin edits course' do
    find("a[href='/admin/courses/#{@course.id}/edit']").click 
    find("input[@id='course_title']").set("edited title")
    click_button "Update Course"
    expect(page).to have_css 'a', text: "edited title"
    expect(page).to have_css 'p', text: "You successfully updated the course"
  end

  scenario 'an admin should not be able to update the course without title' do
    find("a[href='/admin/courses/#{@course.id}/edit']").click 
    find("input[@id='course_title']").set("")
    click_button "Update Course"
    expect(page).to have_css 'p', text: "Title can't be blank"
    expect(Course.find(@course.id).title).not_to eq("")
  end

  scenario 'an admin deletes a course' do
    expect{
      click_link "Delete"
    }.to change(Course, :count).by(-1)
    expect(page).to have_css 'p', text: "you successfully deleted a course"
    expect(current_path).to eq("/admin/courses")
  end

  scenario 'an admin sees researchers belonging to course' do
    researcher = Fabricate(:researcher)
    @course.researchers << researcher
    click_link @course.title
    expect(page).to have_css 'li', text: researcher.fullname 
  end
end

require 'spec_helper'

feature "Admin interacts with researcher" do
  background do
    @researcher = Fabricate(:researcher)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_researchers_path
  end

  scenario "Admin views researchers" do
    expect(page).to have_content @researcher.name
  end

  scenario "Admin clicks researcher link and views researcher details" do
    click_link @researcher.name
    expect(page).to have_css 'h1', text: @researcher.name
    expect(page).to have_css 'p', text: @researcher.bio
    expect(page).to have_css 'a', text: @researcher.email
  end

  scenario "Admin adds a researcher" do
    expect{
      click_link "Add Researcher"
      fill_in 'Name', with: @researcher.name
      fill_in 'Bio', with: @researcher.bio
      fill_in 'Email', with: @researcher.email
      click_button "Add Researcher"
    }.to change(Researcher, :count).by(1)
  end
end

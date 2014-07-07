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

    expect(page).to have_css 'p', text: "You successfully added a new researcher"
  end

  scenario 'Admin should not be able to add research project without name and bio' do
    expect{
      click_link "Add Researcher"
      fill_in 'Name', with: ""
      fill_in 'Bio', with: ""
      click_button "Add Researcher"
    }.not_to change(Researcher, :count).by(1)
    expect(page).to have_css 'p', text: "there was a problem, the researcher was not added"
  end
end

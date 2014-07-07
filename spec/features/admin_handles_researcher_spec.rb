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
end

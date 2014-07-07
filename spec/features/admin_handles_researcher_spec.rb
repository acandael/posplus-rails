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
end

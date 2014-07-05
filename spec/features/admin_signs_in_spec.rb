require 'spec_helper'

feature 'Admin signs in' do
  scenario 'Admin successfully signs in' do
    alice = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign in"
    expect(page).to have_content alice.full_name  
  end
end

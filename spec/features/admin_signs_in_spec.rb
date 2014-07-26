require 'spec_helper'

feature 'Admin signs in' do
  scenario 'Admin successfully signs in' do
    alice = Fabricate(:admin)
    visit signin_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign in"
    expect(page).to have_content alice.full_name  
    expect(page).to have_css 'a', text: "Sign Out"
    expect(page).to have_css 'a[class="sign-up"]', text: "Admin"
    expect(current_path).to eq("/admin")
  end

  scenario 'Admin signs in with invalid credentials' do
    alice = Fabricate(:admin)
    visit signin_path
    fill_in "Email Address", with: "invalid username"
    fill_in "Password", with: alice.password
    click_button "Sign in"
    expect(page).to have_content "Wrong Email/Password combination"
    expect(page).not_to have_css 'a[class="sign-up"]', text: "Admin"
  end

  scenario 'Admin signs out' do
    alice = Fabricate(:admin)
    visit signin_path
    fill_in "Email Address", with: alice.email 
    fill_in "Password", with: alice.password
    click_button "Sign in"
    click_link "Sign Out"
    expect(page).to have_content "You are signed out!"
    expect(current_path).to eq("/")
    expect(page).not_to have_css 'a[class="sign-up"]', text: "Admin"
  end

  scenario 'A regular user should not have access to the dashboard' do
    alice = Fabricate(:user)
    visit signin_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign in"
    expect(page).to have_css 'p', text: "Unauthorized access!"
    expect(page).not_to have_css 'a[class="sign-up"]', text: "Admin"
    expect(current_path).to eq("/home")
  end
end

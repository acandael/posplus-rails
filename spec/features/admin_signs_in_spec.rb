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

  scenario 'Admin signs in with invalid credentials' do
    alice = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: "hello"
    fill_in "Password", with: alice.password
    click_button "Sign in"
    expect(page).to have_content "Wrong Email/Password combination"
  end

  scenario 'Admin signs out' do
    alice = Fabricate(:admin)
    visit sign_in_path
    fill_in "Email Address", with: alice.email 
    fill_in "Password", with: alice.password
    click_button "Sign in"
    click_link "Sign Out"
    expect(page).to have_content "You are signed out!"
  end

  scenario 'Admin signs in and is redirect to dashboard' do
    alice = Fabricate(:admin)
    visit sign_in_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign in"
    expect(page).to have_css 'h1', text: "Dashboard"
  end

  scenario 'A regular user should not have access to the dashboard' do
    alice = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign in"
    expect(page).to have_css 'p', text: "Unauthorized access!"
  end
end

require 'spec_helper'

feature 'Add research theme' do
  scenario 'an admin adds a research theme' do
    visit admin_path
    click_link "Research Themes" 
    expect(page).to have_css 'h1', text: 'Manage Research Themes'
    expect(page).to have_css 'a', text: 'Add Research Theme'
    click_link 'Add Research Theme'
    expect(page).to have_css 'h1', text: 'Add Research Theme'

    fill_in 'Title', with: 'research theme 1'
    fill_in 'Description', with: 'this is the description'
    click_button "Add Research Theme"
    page.should have_content 'research theme 1'
  end
end

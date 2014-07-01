require 'spec_helper'

feature 'Add research theme' do
  scenario 'an admin visits the admin research page' do
    visit admin_path
    click_link "Research Themes" 
    expect(page).to have_css 'h1', text: 'Manage Research Themes'
  end
end

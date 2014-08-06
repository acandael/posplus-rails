require 'spec_helper'

feature 'Contact page' do
  scenario 'visitor visits contact page' do
    visit pages_contact_path
    expect(page).to have_css 'h1', text: "Contact Us"
  end
end

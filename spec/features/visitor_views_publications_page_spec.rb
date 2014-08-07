require 'spec_helper'

feature 'Publications Page' do
  scenario 'visitor visits publication page' do
    visit publications_path
    expect(page).to have_css 'h1', text: "Publications"
  end
end

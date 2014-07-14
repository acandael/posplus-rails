require 'spec_helper'

feature 'Visitor interacts with homepage' do
  scenario 'and sees research themes' do
    @research_theme = Fabricate(:research_theme)
    visit home_path
    expect(page).to have_css 'h3', text: @research_theme.title
    expect(page).to have_css 'p', text: @research_theme.description
  end
end

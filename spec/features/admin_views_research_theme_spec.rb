require 'spec_helper'

feature "Admin views research theme" do
  scenario "Admin clicks research theme link and views research theme show page" do
    research_theme = Fabricate(:research_theme)
    visit admin_research_themes_path
    find("a[href='/admin/research_themes/#{research_theme.id}']").click 
    expect(page).to have_css 'h1', text: research_theme.title
    expect(page).to have_css 'div', text: research_theme.description
  end
end

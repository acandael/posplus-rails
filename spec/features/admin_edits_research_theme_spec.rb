require 'spec_helper'

feature "Admin edits research theme" do
  scenario "Admin edits research theme" do
    research_theme = Fabricate(:research_theme)
    visit admin_research_themes_path
    find("a[href='/admin/research_themes/#{research_theme.id}/edit']").click 
    find("input[@id='research_theme_title']").set("this is the edited description")
    click_button "Update Research Theme"
    page.should have_content "this is the edited description"
  end
end

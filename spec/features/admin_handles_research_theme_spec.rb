require 'spec_helper'

  feature "Admin interacts with research theme" do
    background do
      @research_theme = Fabricate(:research_theme)
      visit admin_research_themes_path
    end
    scenario "Admin views research themes" do
      expect(page).to have_content @research_theme.title
    end

    scenario "Admin clicks research theme link and views research theme show page" do
      click_link @research_theme.title
      expect(page).to have_css 'h1', text: @research_theme.title
      expect(page).to have_css 'div', text: @research_theme.description
    end

    scenario 'an admin adds a research theme' do
      click_link 'Add Research Theme'
      expect(page).to have_css 'h1', text: 'Add Research Theme'

      fill_in 'Title', with: @research_theme.title 
      fill_in 'Description', with: @research_theme.description 
      click_button "Add Research Theme"
      page.should have_content @research_theme.title 
      page.should have_content "you successfully added a new research theme"
    end

    scenario "Admin edits research theme" do
      find("a[href='/admin/research_themes/#{@research_theme.id}/edit']").click 
      find("input[@id='research_theme_title']").set("this is the edited description")
      click_button "Update Research Theme"
      page.should have_content "this is the edited description"
      page.should have_content "you successfully updated the research theme"
    end
    
    scenario "Admin visits research themes page and deletes research theme" do
      click_link "Delete"
      expect(page).not_to have_css 'a', text: @research_theme.title
      expect(page).to have_content "you successfully removed the research theme"
    end
  end

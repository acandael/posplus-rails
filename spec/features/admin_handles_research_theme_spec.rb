require 'spec_helper'

  feature "Admin interacts with research theme" do
    background do
      admin = Fabricate(:admin)
      visit signin_path
      fill_in "Email Address", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Sign in"
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
      expect{
      add_research_theme @research_theme.title, @research_theme.description
      }.to change(ResearchTheme, :count).by(1)

      page.should have_content @research_theme.title 
      page.should have_content "you successfully added a new research theme"
    end

    scenario 'an admin should not be able to add a research theme without title and description' do
      expect{
        add_research_theme "", ""
      }.not_to change(ResearchTheme, :count).by(1)
      page.should have_content "there was a problem, the research theme could not be added" 
    end

    scenario "Admin edits research theme" do
      @research_theme.title = "this is the edited title"
      update_research_theme @research_theme.title, @research_theme.description 
      page.should have_content @research_theme.title
      page.should have_content "you successfully updated the research theme"
    end

    scenario "An admin should not be able to update research theme without title or description" do
      @research_theme.title = ""
      @research_theme.description = ""
      update_research_theme @research_theme.title, @research_theme.description 
      page.should_not have_content "this is the edited title"
      page.should have_content "there was a problem, the research theme could not be updated"
    end
    
    scenario "Admin deletes research theme" do
      expect{
      click_link "Delete"
      }.to change(ResearchTheme, :count).by(-1)
      expect(page).not_to have_css 'a', text: @research_theme.title
      expect(page).to have_content "you successfully removed the research theme"
    end

    scenario "Admin sees research projects for research theme" do
      research_project_1 = Fabricate(:research_project)
      research_project_2 = Fabricate(:research_project)
      @research_theme.research_projects << research_project_1
      @research_theme.research_projects << research_project_2
      click_link @research_theme.title
      expect(page).to have_css 'li', text: research_project_1.title
      expect(page).to have_css 'li', text: research_project_2.title
    end

    def add_research_theme(title, description)
      click_link 'Add Research Theme'
      fill_in 'Title', with: title 
      fill_in 'Description', with: description 
      click_button "Add Research Theme"
    end

    def update_research_theme(title, description)
      find("a[href='/admin/research_themes/#{@research_theme.id}/edit']").click 
      find("input[@id='research_theme_title']").set(title)
      click_button "Update Research Theme"
    end
  end

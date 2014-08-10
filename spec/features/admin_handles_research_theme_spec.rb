require 'spec_helper'

  feature "Admin interacts with research theme" do
    background do
      @research_theme = Fabricate(:research_theme)
      admin = Fabricate(:admin)
      sign_in(admin)
      visit admin_research_themes_path    
    end

    scenario "Admin views research themes" do
      expect(page).to have_content @research_theme.title
    end

    scenario "Admin clicks research theme link and views research theme show page" do
      project = Fabricate(:research_project)
      @research_theme.research_projects << project
      @research_theme.save
      click_link @research_theme.title
      expect(page).to have_css 'h1', text: @research_theme.title
      expect(page).to have_css 'div', text: @research_theme.description
      page.should have_xpath("//img[@src=\"/uploads/research_theme/image/#{@research_theme.id}/#{File.basename(@research_theme.image.url)}\"]")
      expect(page).to have_css 'a', text: project.title
    end

    scenario 'an admin adds a research theme' do
      expect{
      find("input[@value='Add Research Theme']").click
      fill_in 'Title', with: "new theme" 
      fill_in 'Description', with: "description for theme" 
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
      click_button "Add Research Theme"
      }.to change(ResearchTheme, :count).by(1)

      expect(page).to have_css 'a', text: "new theme" 
      expect((ResearchTheme.last).description).to eq("description for theme")
      expect((ResearchTheme.last).image.url).to eq("/uploads/research_theme/image/#{(ResearchTheme.last).id}/jigsaw-puzzle.jpg")
      page.should have_content "you successfully added a new research theme"
    end

    scenario 'an admin should not be able to add a research theme without title' do
      expect{
        find("input[@value='Add Research Theme']").click
        fill_in 'Title', with: "" 
        fill_in 'Description', with: "description for theme" 
        attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
        click_button "Add Research Theme"
      }.not_to change(ResearchTheme, :count).by(1)
      expect((ResearchTheme.last).title).not_to eq("")
      expect(page).to have_css 'p', text: "Title can't be blank"
    end

    scenario 'an admin should not be able to add a research theme without description' do
      expect{
        find("input[@value='Add Research Theme']").click
        fill_in 'Title', with: "new theme" 
        fill_in 'Description', with: "" 
        attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
        click_button "Add Research Theme"
      }.not_to change(ResearchTheme, :count).by(1)
      expect((ResearchTheme.last).title).not_to eq("new theme")
      expect((ResearchTheme.last).title).not_to eq("")
      expect(page).to have_css 'p', text: "Description can't be blank"
    end

    scenario 'an admin should not be able to add a theme with a duplicate title' do
      @duplicate_theme = Fabricate(:research_theme)
      expect{
        find("input[@value='Add Research Theme']").click
        fill_in 'Title', with: @duplicate_theme.title 
        fill_in 'Description', with: "some description" 
        attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
        click_button "Add Research Theme"
      }.not_to change(ResearchTheme, :count).by(1)
      expect(page).to have_css 'p', text: "Title has already been taken"
    end

    scenario "Admin edits research theme" do
      find("a[href='/admin/research_themes/#{@research_theme.id}/edit']").click 
      find("input[@id='research_theme_title']").set("edited title")
      find("textarea[@id='research_theme_description']").set("edited description")
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"

      click_button "Update Research Theme"

      expect(page).to have_css 'a', text: "edited title" 
      expect((ResearchTheme.last).description).to eq("edited description") 
      expect((ResearchTheme.last).image.url).to eq("/uploads/research_theme/image/#{@research_theme.id}/jigsaw-puzzle.jpg")
      page.should have_content "you successfully updated the research theme"
    end

    scenario "An admin should not be able to update research theme without title" do
      find("a[href='/admin/research_themes/#{@research_theme.id}/edit']").click 
      find("input[@id='research_theme_title']").set("")
      find("textarea[@id='research_theme_description']").set("edited description")
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"

      click_button "Update Research Theme"
      expect(page).to have_css 'p', text: "Title can't be blank"
    end

    scenario "An admin should not be able to update research theme without description" do
      find("a[href='/admin/research_themes/#{@research_theme.id}/edit']").click 
      find("input[@id='research_theme_title']").set("edited title")
      find("textarea[@id='research_theme_description']").set("")
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"

      click_button "Update Research Theme"
      expect(page).to have_css 'p', text: "Description can't be blank"
    end

    scenario "An admin should not be able to update research theme with duplicate title" do
      @duplicate_theme = Fabricate(:research_theme)

      find("a[href='/admin/research_themes/#{@research_theme.id}/edit']").click 
      find("input[@id='research_theme_title']").set(@duplicate_theme.title)
      find("textarea[@id='research_theme_description']").set("some description")
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"

      click_button "Update Research Theme"
      expect(page).to have_css 'p', text: "Title has already been taken"

    end
    
    scenario "Admin deletes research theme" do
      expect{
      click_link "Delete"
      }.to change(ResearchTheme, :count).by(-1)
      expect(page).not_to have_css 'a', text: @research_theme.title
      expect(page).to have_content "you successfully removed the research theme"
      expect(current_path).to eq admin_research_themes_path
    end

    scenario "An admin should not be able to delete a research theme when it still has research projects" do
      research_project = Fabricate(:research_project)
      @research_theme.research_projects << research_project
      @research_theme.save
      expect{
        click_link "Delete"
      }.not_to change(ResearchTheme, :count).by(-1)
      expect(page).to have_content "cannot delete research theme that still has research projects"
      expect(current_path).to eq admin_research_themes_path
    end
  end

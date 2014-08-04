require 'spec_helper'

feature "affiliated research groups" do
  background do
    @research_group = Fabricate(:research_group)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_research_groups_path
  end

  scenario "Admin views research groups" do
    within('div.panel') { expect(page).to have_css 'td', text: @research_group.name }
  end

  scenario "Admin clicks research group link and views research group details" do
    click_link @research_group.name

    expect(page).to have_css 'h1', text: @research_group.name
    page.should have_xpath("//img[@src=\"/uploads/research_group/image/#{@research_group.id}/#{File.basename(@research_group.image.url)}\"]")
    expect(page).to have_css 'a', text: @research_group.website
  end

  scenario "Admin adds a research group" do
    expect{
      find("input[@value='Add Affiliated Research Group']").click
      fill_in 'Name', with: "some name"
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
      fill_in 'Website', with: "http://www.chegg.ugent.be"
      click_button "Add Affiliated Research Group"
    }.to change(ResearchGroup, :count).by(1)
    expect(page).to have_css "p", text: "you successfully added research group"
    expect((ResearchGroup.last).image.url).to eq("/uploads/research_group/image/#{@research_group.id + 1}/jigsaw-puzzle.jpg")
  end

  scenario "Admin should not be able to add research group without name" do
    expect{
      find("input[@value='Add Affiliated Research Group']").click
      fill_in 'Name', with: ""
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
      fill_in 'Website', with: "http://www.chegg.ugent.be"
      click_button "Add Affiliated Research Group"
    }.not_to change(ResearchGroup, :count).by(1)
    expect(page).to have_css 'p', text: "Name can't be blank"
  end

  scenario "Admin should not be able to add research group with invalid url" do
    expect{
      find("input[@value='Add Affiliated Research Group']").click
      fill_in 'Name', with: "some name"
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
      fill_in 'Website', with: "hello hello"
      click_button "Add Affiliated Research Group"
    }.not_to change(ResearchGroup, :count).by(1)
    expect(page).to have_css 'p', text: "Website is invalid"
  end

  scenario "Admin should not be able to add research group if the name already exists" do
    research_group2 = Fabricate(:research_group)
    expect{
      find("input[@value='Add Affiliated Research Group']").click
      fill_in 'Name', with: research_group2.name
      attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
      fill_in 'Website', with: "http://www.chegg.ugent.be"
      click_button "Add Affiliated Research Group"
    }.not_to change(ResearchGroup, :count).by(1)
    expect(page).to have_content "Name has already been taken"
  end

  scenario "Admin edits research group" do
    find("a[href='/admin/research_groups/#{@research_group.id}/edit']").click
    find("input[@id='research_group_name']").set("chegg")
    attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
    click_button "Update Affiliated Research Group"
    expect(page).to have_content "chegg"
    expect(page).to have_content "you successfully updated the research group"
  end

  scenario "Admin should not be able to update research group without name" do
    find("a[href='/admin/research_groups/#{@research_group.id}/edit']").click
    find("input[@id='research_group_name']").set("")
    attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
    click_button "Update Affiliated Research Group"
    expect(ResearchGroup.find(@research_group.id).name).not_to eq("")
    expect(page).to have_css "p", text: "Name can't be blank"
  end

  scenario "Admin should not be able to update research group with invalid url" do
    find("a[href='/admin/research_groups/#{@research_group.id}/edit']").click
    find("input[@id='research_group_name']").set("chegg")
    attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
    find("input[@id='research_group_website']").set("hello hello")
    click_button "Update Affiliated Research Group"
    expect(ResearchGroup.find(@research_group.id).website).not_to eq("hello hello")
    expect(page).to have_css "p", text: "Website is invalid"
  end

  scenario "Admin deletes research group" do
    expect{
      click_link "Delete"
    }.to change(ResearchGroup, :count).by(-1)
    expect(page).to have_css 'p', text: "you successfully deleted research group"
  end

  scenario "When no research groups admin should see no research groups available message" do
    expect{
      click_link "Delete"
    }.to change(ResearchGroup, :count).by(-1)
    within('div.panel') { expect(page).to have_css 'td', text: "no affiliated research groups available" }
  end

end


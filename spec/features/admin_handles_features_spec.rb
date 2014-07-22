require 'spec_helper'

feature "Admin interacts with features" do
  background do
    @feature = Fabricate(:feature)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_features_path
  end

  scenario "Admin views features" do
    expect(page).to have_css 'td', text: @feature.title
  end

  scenario "Admin clicks feature link and views feature details" do
    click_link @feature.title
    expect(page).to have_css 'h1', text: @feature.title
    expect(page).to have_css 'div', text: @feature.body
  end

  scenario 'Admin adds a feature' do
    expect{
      find("input[@value='Add Feature']").click
      fill_in 'Title', with: "some title"
      fill_in 'Body', with: "description for feature"
      click_button "Add Feature"
    }.to change(Feature, :count).by(1)

    expect(page).to have_css 'a', text: "some title"
    expect(page).to have_css 'p', text: "You successfully added a new feature!"
  end

  scenario 'Admin should not be able to add feature without title' do
    expect{
      find("input[@value='Add Feature']").click
      fill_in 'Title', with: ""
      fill_in 'Body', with: "description for feature"
      click_button "Add Feature"
    }.not_to change(Feature, :count).by(1)
    expect(page).to have_css 'p', text: "Title can't be blank"
  end

  scenario 'Admin should not be able to add feature without body text' do
    expect{
      find("input[@value='Add Feature']").click
      fill_in 'Title', with: "some title"
      fill_in 'Body', with: ""
      click_button "Add Feature"
    }.not_to change(Feature, :count).by(1)
    expect(page).to have_css 'p', text: "Body can't be blank"
  end

  scenario 'Admin edits feature' do
    find("a[href='/admin/features/#{@feature.id}/edit']").click
    find("input[@id='feature_title']").set("edited title")
    find("textarea[@id='feature_body']").set("edited bodytext")
    click_button "Update Feature"
    expect(page).to have_css 'td', text: "edited title"
    expect(Feature.find(@feature).body).to eq("edited bodytext")
    expect(page).to have_css 'p', text: "You successfully updated the feature!"
  end

  scenario 'Admin should not be able to update feature without title' do
    find("a[href='/admin/features/#{@feature.id}/edit']").click
    find("input[@id='feature_title']").set("")
    find("textarea[@id='feature_body']").set("edited bodytext")
    click_button "Update Feature"
    expect(Feature.find(@feature).title).not_to eq("") 
    expect(Feature.find(@feature).body).not_to eq("edited bodytext") 
    expect(current_path).to eq("/admin/features/#{@feature.id}")
    expect(page).to have_css 'p', text: "Title can't be blank"
  end

  scenario 'Admin should not be able to update feature without bodytext' do
    find("a[href='/admin/features/#{@feature.id}/edit']").click
    find("input[@id='feature_title']").set("edited title")
    find("textarea[@id='feature_body']").set("")
    click_button "Update Feature"
    expect(Feature.find(@feature).title).not_to eq("edited title")
    expect(Feature.find(@feature).body).not_to eq("") 
    expect(current_path).to eq("/admin/features/#{@feature.id}")
    expect(page).to have_css 'p', text: "Body can't be blank"
  end

  scenario 'Admin deletes feature' do
    expect{
      click_link "Delete"
    }.to change(Feature, :count).by(-1)
  end
end

require 'spec_helper'

feature "Admin interacts with features" do
  background do
    admin = Fabricate(:admin)
    sign_in(admin)
  end

  scenario 'Admin should not see Add Feature button when a feature exists' do
    feature_item = Fabricate(:feature) 
    visit admin_features_path
    expect(page).not_to have_content "Add Feature"
  end

  scenario 'Admin should see Add Feature button when no feature exists' do
    visit admin_features_path
    page.should have_selector(:link_or_button, 'Add Feature')
  end
  
  scenario "Admin sees no items message when no features exists" do
    visit admin_features_path
    expect(page).to have_css 'p', text: "There are no features. Click 'Add Feature' to create one."
  end

  scenario "Admin views features" do
    feature_item = Fabricate(:feature)
    visit admin_features_path
    within('table.table-borders') { expect(page).to have_css 'a', text: feature_item.title }
  end

  scenario "Admin clicks feature link and views feature details" do
    feature_item = Fabricate(:feature)
    visit admin_features_path
    click_link feature_item.title
    expect(page).to have_css 'h1', text: feature_item.title
    expect(page).to have_css 'div', text: feature_item.body
    page.should have_xpath("//img[@src=\"/uploads/feature/image/#{File.basename(feature_item.image.url)}\"]")
    expect(page).to have_css 'a', text: File.basename(feature_item.document.url)
  end

  scenario 'Admin adds a feature' do
    visit admin_features_path
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
    visit admin_features_path
    expect{
      find("input[@value='Add Feature']").click
      fill_in 'Title', with: ""
      fill_in 'Body', with: "description for feature"
      click_button "Add Feature"
    }.not_to change(Feature, :count).by(1)
    expect(page).to have_css 'p', text: "Title can't be blank"
  end

  scenario 'Admin should not be able to add feature without body text' do
    visit admin_features_path
    expect{
      find("input[@value='Add Feature']").click
      fill_in 'Title', with: "some title"
      fill_in 'Body', with: ""
      click_button "Add Feature"
    }.not_to change(Feature, :count).by(1)
    expect(page).to have_css 'p', text: "Body can't be blank"
  end

  scenario 'Admin edits feature' do
    feature_item = Fabricate(:feature)
    visit admin_features_path
    find("a[href='/admin/features/#{feature_item.id}/edit']").click
    find("input[@id='feature_title']").set("edited title")
    find("textarea[@id='feature_body']").set("edited bodytext")
    click_button "Update Feature"
    expect(page).to have_css 'td', text: "edited title"
    expect(Feature.find(feature_item).body).to eq("edited bodytext")
    expect(page).to have_css 'p', text: "You successfully updated the feature!"
  end

  scenario 'Admin should not be able to update feature without title' do
    feature_item = Fabricate(:feature) 
    visit admin_features_path
    find("a[href='/admin/features/#{feature_item.id}/edit']").click
    find("input[@id='feature_title']").set("")
    find("textarea[@id='feature_body']").set("edited bodytext")
    click_button "Update Feature"
    expect(Feature.find(feature_item).title).not_to eq("") 
    expect(Feature.find(feature_item).body).not_to eq("edited bodytext") 
    expect(current_path).to eq("/admin/features/#{feature_item.id}")
    expect(page).to have_css 'p', text: "Title can't be blank"
  end

  scenario 'Admin should not be able to update feature without bodytext' do
    feature_item = Fabricate(:feature) 
    visit admin_features_path
    find("a[href='/admin/features/#{feature_item.id}/edit']").click
    find("input[@id='feature_title']").set("edited title")
    find("textarea[@id='feature_body']").set("")
    click_button "Update Feature"
    expect(Feature.find(feature_item).title).not_to eq("edited title")
    expect(Feature.find(feature_item).body).not_to eq("") 
    expect(current_path).to eq("/admin/features/#{feature_item.id}")
    expect(page).to have_css 'p', text: "Body can't be blank"
  end

  scenario 'Admin deletes feature' do
    feature_item = Fabricate(:feature) 
    visit admin_features_path
    expect{
      click_link "Delete"
    }.to change(Feature, :count).by(-1)
  end

end

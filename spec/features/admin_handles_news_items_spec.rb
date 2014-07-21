require 'spec_helper'

feature 'Admin interacts with news' do
  background do
    @news_item = Fabricate(:news_item)
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_news_items_path
  end

  scenario "Admin views news items" do
    expect(page).to have_css 'td', text: @news_item.title
  end

  scenario "Admin clicks news item link and views news item details" do
    click_link @news_item.title
    expect(page).to have_css 'h1', text: @news_item.title
    expect(page).to have_css 'p', text: @news_item.body
  end

  scenario 'Admin adds a news item' do
    expect{
      find("input[@value='Add News Item']").click
      fill_in 'Title', with: "some title"
      fill_in 'Body', with: "some content"
      click_button "Add News Item"
    }.to change(NewsItem, :count).by(1)
    expect(page).to have_css 'p', text: "You successfully added a news item"
  end

  scenario 'Admin should not be able to add news item without title and body' do
    expect{
      find("input[@value='Add News Item']").click
      fill_in 'Title', with: ""
      fill_in 'Body', with: "some body text"
      click_button "Add News Item"
    }.not_to change(NewsItem, :count).by(1)
    expect(page).to have_css 'p', text: "There was a problem, the news item could not be added"
  end

  scenario 'Admin edits news item' do
    @news_item.title = "edited title"
    find("a[href='/admin/news_items/#{@news_item.id}/edit']").click 
    find("input[@id='news_item_title']").set(@news_item.title)
    click_button "Update News Item"
    expect(NewsItem.find(@news_item.id).title).to eq("edited title")
    expect(page).to have_content "You successfully updated the news item"
  end

  scenario 'Admin should not be able to update news item without title or body text' do
    @news_item.title = ""
    find("a[href='/admin/news_items/#{@news_item.id}/edit']").click 
    find("input[@id='news_item_title']").set(@news_item.title)
    click_button "Update News Item"
    expect(NewsItem.find(@news_item).title).not_to eq("")
    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Admin deletes news item' do
    expect{
      click_link "Delete"
    }.to change(NewsItem, :count).by(-1)
    expect(page).to have_css 'p', text: "You successfully deleted a news item"
  end

  scenario 'Admin hides news item' do
    save_and_open_page
    click_link "Hide"
    @news_item.reload
    expect(@news_item.visible?).to be_false
    expect(page).to have_css 'a', text: "Show"
    expect(page).to have_css 'p', text: "The news item was successfully updated!"
  end

end

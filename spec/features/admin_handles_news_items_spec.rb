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
    page.should have_xpath("//img[@src=\"/uploads/news_item/image/#{File.basename(@news_item.image.url)}\"]")
    expect(page).to have_css 'a', text: File.basename(@news_item.document.url)

  end

  scenario 'Admin adds a news item' do
    expect{
      find("input[@value='Add News Item']").click
      fill_in 'Title', with: "some title"
      fill_in 'Body', with: "some content"
      attach_file 'Image', "spec/support/uploads/monk_large.jpg"
      fill_in 'Link', with: "http://www.somelink.com"
      click_button "Add News Item"
    }.to change(NewsItem, :count).by(1)
    expect((NewsItem.last).title).to eq("some title")
    expect((NewsItem.last).body).to eq("some content")
    expect((NewsItem.last).image.url).to eq("/uploads/news_item/image/monk_large.jpg")
    expect((NewsItem.last).link).to eq("http://www.somelink.com")
    expect(page).to have_css 'p', text: "You successfully added a news item"
  end

  scenario 'Admin should not be able to add news item without title' do
    expect{
      find("input[@value='Add News Item']").click
      fill_in 'Title', with: ""
      fill_in 'Body', with: "some body text"
      click_button "Add News Item"
    }.not_to change(NewsItem, :count).by(1)
    expect(page).to have_css 'p', text: "There was a problem, the news item could not be added"
    expect(@news_item.title).not_to eq("")
    expect(@news_item.body).not_to eq("some body text")
  end

  scenario 'Admin should not be able to add news item without title' do
    expect{
      find("input[@value='Add News Item']").click
      fill_in 'Title', with: "new news item"
      fill_in 'Body', with: ""
      click_button "Add News Item"
    }.not_to change(NewsItem, :count).by(1)
    expect(page).to have_css 'p', text: "There was a problem, the news item could not be added"
    expect(@news_item.title).not_to eq("new news item")
    expect(@news_item.body).not_to eq("")
  end

  scenario 'Admin edits news item' do
    find("a[href='/admin/news_items/#{@news_item.id}/edit']").click 
    find("input[@id='news_item_title']").set("some title")
    find("textarea[@id='news_item_body']").set("some bodytext")
    attach_file 'Image', "spec/support/uploads/jigsaw-puzzle.jpg"
    find("input[@id='news_item_link']").set("http://www.some-link.com")
    click_button "Update News Item"
    @news_item.reload
    expect(@news_item.title).to eq("some title")
    expect(@news_item.body).to eq("some bodytext")
    expect(@news_item.image.url).to eq("/uploads/news_item/image/jigsaw-puzzle.jpg")
    expect(@news_item.link).to eq("http://www.some-link.com")
    expect(page).to have_content "You successfully updated the news item"
  end

  scenario 'Admin should not be able to update news item without title' do
    find("a[href='/admin/news_items/#{@news_item.id}/edit']").click 
    find("input[@id='news_item_title']").set("")
    find("textarea[@id='news_item_body']").set("some bodytext")
    click_button "Update News Item"
    @news_item.reload
    expect(@news_item.title).not_to eq("")
    expect(@news_item.body).not_to eq("some bodytext")
    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Admin should not be able to update news item without bodytext' do
    find("a[href='/admin/news_items/#{@news_item.id}/edit']").click 
    find("input[@id='news_item_title']").set("some title")
    find("textarea[@id='news_item_body']").set("")
    click_button "Update News Item"
    @news_item.reload
    expect(@news_item.title).not_to eq("some title")
    expect(@news_item.body).not_to eq("")
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Admin deletes news item' do
    expect{
      click_link "Delete"
    }.to change(NewsItem, :count).by(-1)
    expect(page).to have_css 'p', text: "You successfully deleted a news item"
    expect(current_path).to eq("/admin/news_items")
  end

  scenario 'Admin hides news item' do
    click_link "Hide"
    @news_item.reload
    expect(@news_item.visible?).to be_false
    expect(page).to have_css 'a', text: "Show"
    expect(page).to have_css 'p', text: "The news item was successfully updated!"
  end

end

require 'spec_helper'

feature "Visitor interacts with news items" do
  scenario 'visitor clicks news item on home page and sees news item details' do
    news_item = Fabricate(:news_item)
    visit home_path
    click_link news_item.title
    expect(page).to have_css 'h1', text: news_item.title
    expect(page).to have_css 'p', text: news_item.body
    expect(page).to have_css 'a', text: news_item.link 
  end

end

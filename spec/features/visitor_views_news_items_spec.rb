require 'spec_helper'

feature "Visitor interacts with news items" do
  scenario 'visitor clicks news item on home page and sees news item details' do
    news_item = Fabricate(:news_item)
    visit home_path
    click_link news_item.title
    expect(page).to have_css 'h1', text: news_item.title
    expect(page).to have_css 'time', text: news_item.created_at.strftime('%d %B %Y') 
    expect(page).to have_css 'p', text: news_item.body
    expect(page).to have_css 'a', text: news_item.link 
    expect(page).to have_css 'a', text: File.basename(news_item.document.url)
    page.should have_xpath("//img[@src=\"/uploads/news_item/image/#{File.basename(news_item.image.url)}\"]")
    expect(page).to have_css 'a', text: File.basename(news_item.document.url)
  end

end

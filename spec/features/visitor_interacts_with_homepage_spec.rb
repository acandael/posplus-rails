require 'spec_helper'

feature 'Visitor interacts with homepage' do
  scenario 'and sees research themes' do
    @research_theme = Fabricate(:research_theme)
    visit home_path
    expect(page).to have_css 'h3', text: @research_theme.title
    expect(page).to have_css 'p', text: @research_theme.description
  end

  scenario 'and sees news items' do
    @news_item = Fabricate(:news_item)
    visit home_path
    expect(page).to have_css 'a', text: @news_item.title
  end

  scenario 'and does not see hidden news item' do
    @news_item = Fabricate(:news_item)
    @news_item.visible = false
    @news_item.save
    visit home_path
    expect(page).not_to have_css 'a', text: @news_item.title
  end
end

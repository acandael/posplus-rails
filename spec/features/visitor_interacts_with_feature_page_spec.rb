require 'spec_helper'

feature 'Visitor interacts with feature page' do
  scenario 'and sees feature details' do
    feature_item = Fabricate(:feature)
    visit feature_path(feature_item)
    expect(page).to have_css 'h1', text: feature_item.title
    expect(page).to have_css 'p', text: feature_item.body
    page.should have_xpath("//img[@src=\"/uploads/feature/image/#{File.basename(feature_item.image.url)}\"]")
    expect(page).to have_css 'a', text: File.basename(feature_item.document.url)
  end
end

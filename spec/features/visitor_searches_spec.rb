require 'spec_helper'

feature 'Search' do
  scenario 'visitor searches for publications and views 1 result' do
    visit home_path
    find("input[@id='q']").set("energy") 
    find("button[@type='submit']").click
    expect(page).to have_css 'h1', text: "Search Results"
    expect(page).to have_css 'p', text: "The search 'energy' has 1 result"
    expect(page).to have_css 'a', text: "The Energy Project"
    expect(page).to have_css 'p', text: "Research project about financing strategies for renewable energy"
    expect(page).to have_css 'em.highlight', text: "energy"
  end

  scenario 'visitor searches for publications and has no results' do
    visit home_path
    find("input[@id='q']").set("humpty dumpty") 
    find("button[@type='submit']").click
    expect(page).to have_css 'h1', text: "Search Results"
    expect(page).to have_css 'p', text: "The search 'humpty dumpty' has no results"
  end
end

require 'spec_helper'

feature 'View the dashboard' do
 before do
   admin = Fabricate(:admin)
   sign_in(admin)
   visit admin_path
 end
 scenario 'an admin learns about the dashboard' do
   expect(page).to have_css 'h1', text: 'Dashboard'
 end

 scenario 'an admin sees the research themes link' do
   expect(page).to have_link("Research Themes", :href=>"/admin/research_themes")
 end

 scenario 'an admin sees the research projects link' do
   expect(page).to have_link("Research Projects", :href=>"/admin/research_projects")
 end

 scenario 'an admin sees the researchers link' do
   expect(page).to have_link("Researchers", :href=>"/admin/researchers")
 end

 scenario 'an admin sees the courses link' do
   expect(page).to have_link("Courses", :href=>"/admin/courses")
 end

 scenario 'an admin sees the news items link' do
   expect(page).to have_link("News Items", :href=>"/admin/news_items")
 end

 scenario 'an admin sees the publications link' do
   expect(page).to have_link("Publications", :href=>"/admin/publications") 
 end

 scenario "an admin sees the 'in the picture' link" do
   expect(page).to have_link("In the picture", :href=>"/admin/features")
 end
end

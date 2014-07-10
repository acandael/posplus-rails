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
   expect(page).to have_css 'a', text: 'Research Themes'
 end

 scenario 'an admin sees the researchers link' do
   expect(page).to have_css 'a', text: 'Researchers'
 end

 scenario 'an admin sees the courses link' do
   expect(page).to have_css 'a', text: 'Courses'
 end

 scenario 'an admin sees the news items link' do
   expect(page).to have_css 'a', text: 'News Items'
 end
end

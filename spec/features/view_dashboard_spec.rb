require 'spec_helper'

feature 'View the dashboard' do
 scenario 'an admin learns about the dashboard' do
   admin = Fabricate(:admin)
   sign_in(admin)
   visit admin_path
   expect(page).to have_css 'h1', text: 'Dashboard'
 end

 scenario 'an admin sees the research themes link' do
   admin = Fabricate(:admin)
   sign_in(admin)
   visit admin_path
   expect(page).to have_css 'a', text: 'Research Themes'
 end

 scenario 'an admin sees the researchers link' do
   admin = Fabricate(:admin)
   sign_in(admin)
   visit admin_path
   expect(page).to have_css 'a', text: 'Researchers'
 end
end

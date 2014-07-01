require 'spec_helper'

feature 'View the dashboard' do
 scenario 'an admin learns about the dashboard' do
   visit admin_path
   expect(page).to have_css 'h1', text: 'Dashboard'
 end
end

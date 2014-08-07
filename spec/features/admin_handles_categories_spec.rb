require 'spec_helper'

feature 'Categories' do
  background do
    admin = Fabricate(:admin)
    sign_in(admin)
    visit admin_publications_path
  end
end

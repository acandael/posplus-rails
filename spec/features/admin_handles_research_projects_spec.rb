require 'spec_helper'

feature "Admin interacts with research projects" do
  scenario "Admin views research projects" do
    visit admin_research_projects_path    
  end
end

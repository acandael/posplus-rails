require 'spec_helper'

describe ResearchTheme do
  it "should not destroy itself if it has research projects" do
    research_theme = Fabricate(:research_theme)
    research_project = Fabricate(:research_project)
    research_theme.research_projects << research_project
    research_theme.destroy
    expect(ResearchTheme.count).not_to eq(0)
  end

  it "should set the custom error message" do
    research_theme = Fabricate(:research_theme)
    research_project = Fabricate(:research_project)
    research_theme.research_projects << research_project
    research_theme.destroy
    expect(research_theme.errors[:base]).to eq ['cannot delete research theme that still has research projects']
  end
end

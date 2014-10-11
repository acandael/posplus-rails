require 'spec_helper'

describe "A research group" do
  it "requires a name" do
    research_group = Fabricate(:research_group)

    research_group.name = ""

    expect(research_group.valid?).to be_false
  end

  it "requires a unique name" do
    research_group1 = Fabricate(:research_group)
    research_group2 = Fabricate(:research_group)

    research_group2.name = research_group1.name

    expect(research_group2.valid?).to be_false
  end

  it "accepts a properly formatted url" do
    websites = %w[http://www.website.com https://www.website.com]

    websites.each do |website|
      research_group = Fabricate(:research_group)
      research_group.website = website
      
      expect(research_group.valid?).to be_true
    end
  end

  it "rejects improperly formatted url's" do
    websites = %w[www.website.com website.com]
    websites.each do |website|
      research_group = Fabricate(:research_group)
      research_group.website = website
      
      expect(research_group.valid?).to be_false
    end
  end
end

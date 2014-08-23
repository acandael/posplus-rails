require 'spec_helper'

describe Publication do
  it "should return 3 latest publications" do
    publication1 = Fabricate(:publication)
    publication2 = Fabricate(:publication)
    publication3 = Fabricate(:publication)
    publication4 = Fabricate(:publication)

    expect(Publication.latest.size).to eq(3)
    expect(Publication.latest).not_to include(publication4)
  end
end

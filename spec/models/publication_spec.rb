require 'spec_helper'

describe Publication do
  it "requires a title" do
    publication = Fabricate(:publication)

    publication.title = ""

    expect(publication.valid?).to be_false
  end

  it "requires a bodytext" do
    publication = Fabricate(:publication)

    publication.body = ""

    expect(publication.valid?).to be_false
  end

  it "requires a year" do
    publication = Fabricate(:publication)

    publication.year = nil 

    expect(publication.valid?).to be_false
  end

  it "requires a valid year" do
    publication = Fabricate(:publication)

    publication.year = 899 

    expect(publication.valid?).to be_false
  end
  it "should return 3 latest publications" do
    publication1 = Fabricate(:publication)
    publication2 = Fabricate(:publication)
    publication3 = Fabricate(:publication)
    publication4 = Fabricate(:publication)

    expect(Publication.latest.size).to eq(3)
    expect(Publication.latest).not_to include(publication4)
  end

  it "should return 3 latest publications in chronological descending order" do
    publication1 = Publication.create(title: "fist publication", body: "reference for first publication", year: 2012) 
    publication2 = Publication.create(title: "seconde publication", body: "reference for second publication", year: 2013) 
    publication3 = Publication.create(title: "third publication", body: "reference for third publication", year: 2014) 

    expect(Publication.latest.first).to eq(publication3)
    expect(Publication.latest.last).to eq(publication1)
  end
end

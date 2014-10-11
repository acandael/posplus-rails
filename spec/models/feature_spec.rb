require 'spec_helper'

describe "A feature" do
  it "requires a title" do
    feature = Fabricate(:feature)

    feature.title = ""

    expect(feature.valid?).to be_false
  end

  it "requires a bodytext" do
    feature = Fabricate(:feature)

    feature.body = ""

    expect(feature.valid?).to be_false
  end
end

require 'spec_helper'

describe "A researcher" do
  it "requires a first name" do
    researcher = Fabricate(:researcher)
    researcher.first_name = ""

    expect(researcher.valid?).to be_false
  end
  it "requires a last name" do
    researcher = Fabricate(:researcher)
    researcher.last_name = ""

    expect(researcher.valid?).to be_false
  end
  it "requires a unique combination of first and last name" do
    researcher1 = Fabricate(:researcher)
    researcher2 = Fabricate(:researcher)

    researcher2.first_name = researcher1.first_name
    researcher2.last_name = researcher1.last_name

    expect(researcher2.valid?).to be_false
  end
  it "requires a bio" do
    researcher = Fabricate(:researcher)
    researcher.bio = ""

    expect(researcher.valid?).to be_false
  end
  it "requires an email" do
    researcher = Fabricate(:researcher)
    researcher.email = ""

    expect(researcher.valid?).to be_false
    expect(researcher.errors[:email].any?).to be_true
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com]
    emails.each do |email|
      researcher = Fabricate(:researcher)
      researcher.email = email

      expect(researcher.valid?).to be_true
      expect(researcher.errors[:email].any?).to be_false
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      researcher = Fabricate(:researcher) 
      researcher.email = email

      expect(researcher.valid?).to be_false
      expect(researcher.errors[:email].any?).to be_true
    end
  end
  
  it "requires a unique, case insensitive email address" do
    researcher1 = Fabricate(:researcher) 
    researcher2 = Fabricate(:researcher)
    researcher2.email = researcher1.email.upcase

    expect(researcher2.valid?).to be_false
    expect(researcher2.errors[:email].first).to eq("has already been taken")
  end
end



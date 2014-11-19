require 'spec_helper'

describe "A user" do
  it "requires a password" do
    user = Fabricate(:user)

    user.password = nil

    expect(user.valid?).to be_false
  end

  it "rejects a password with less then 8 characters" do
    user = Fabricate(:user)

    user.password = "1234567"

    expect(user.valid?).to be_false
  end

  it "accepts a password with 8 characters" do
    user = Fabricate(:user)

    user.password = "12345678"

    expect(user.valid?).to be_true
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com]
    emails.each do |email|
      user = Fabricate(:user)
      user.email = email

      expect(user.valid?).to be_true
      expect(user.errors[:email].any?).to be_false
    end
  end

  it "rejects badly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      user = Fabricate(:user)
      user.email = email

      expect(user.valid?).to be_false
      expect(user.errors[:email].any?).to be_true
    end
  end

  it "requires a unique email address" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)

    user2.email = user1.email

    expect(user2.valid?).to be_false
    expect(user2.errors[:email].first).to eq("has already been taken")
  end
end

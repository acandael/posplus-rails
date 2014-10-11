require 'spec_helper'

describe "A news-item" do
  it "requires a title" do
    news_item = Fabricate(:news_item)

    news_item.title = ""

    expect(news_item.valid?).to be_false
  end

  it "requires a bodytext" do
    news_item = Fabricate(:news_item)

    news_item.body = ""

    expect(news_item.valid?).to be_false
  end
end

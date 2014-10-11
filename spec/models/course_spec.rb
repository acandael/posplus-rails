require 'spec_helper'

describe "A course" do
  it "requires a title" do
    course = Fabricate(:course)

    course.title = ""

    expect(course.valid?).to be_false
  end

  it "requires a unique course title" do
    course1 = Fabricate(:course)
    course2 = Fabricate(:course)

    course2.title = course1.title

    expect(course2.valid?).to be_false
  end
end

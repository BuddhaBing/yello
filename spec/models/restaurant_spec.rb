require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is not valid with a name of less than 3 chars" do
    restaurant = Restaurant.new(name:"na")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end
end
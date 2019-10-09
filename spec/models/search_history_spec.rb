require 'rails_helper'

RSpec.describe SearchHistory, type: :model do
  it "should create new row in the table everytime year and population is passed" do
    expect(SearchHistory.log(1900, 12345).id).to eq(SearchHistory.last.id)
  end
end

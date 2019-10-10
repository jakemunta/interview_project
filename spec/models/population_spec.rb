require 'rails_helper'

RSpec.describe Population, type: :model do

  it "should accept a year we know and return the correct population" do
    expect(Population.get(1900)).to eq(76212168)
    expect(Population.get(1990)).to eq(248709873)
  end

  it "should accept a year we don't know and return the previous known population" do
    expect(Population.get(1902)).to eq(79415433)
    expect(Population.get(1908)).to eq(89025230)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(1800)).to eq(0)
    expect(Population.get(0)).to eq(0)
    expect(Population.get(-1000)).to eq(0)
  end

  it "should accept a year that is after latest known and return the last known population" do
    expect(Population.get(2000)).to eq(248709873)
    expect(Population.get(200000)).to eq(248709918)
    expect(Population.get(2500)).to eq(248709918)
  end

  it "should return all the exact matches year with the total count of searches" do
    population = Population.find_by_year(Date.new(1990))
    SearchHistory.create(year: population.year.year, result: population.population, population_id: population.id)
    search_count = Population.search_count_by_year.first
    expect(search_count.year.year).to eq(1990)
    expect(search_count.search_count).to eq(1)

    SearchHistory.create(year: population.year.year, result: population.population, population_id: population.id)
    search_count = Population.search_count_by_year.first
    expect(search_count.year.year).to eq(1990)
    expect(search_count.search_count).to eq(2)

  end

  it "should not return if match is not exact" do
    population = Population.find_by_year(Date.new(1985))
    SearchHistory.create(year: 1985, result: 972313123, population_id: nil)
    search_count = Population.search_count_by_year.first
    expect(search_count).to eq(nil)
  end

end

class SearchHistory < ApplicationRecord

  def self.log(year, result)
    population = Population.by_year(year)
    exact_match, population_id = nil, nil
    if population
      exact_match = true
      population_id = population.id
    end
    create(year: year, result: result, exact_match: exact_match, population_id: population_id)
  end

end

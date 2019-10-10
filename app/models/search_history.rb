class SearchHistory < ApplicationRecord
  def self.log(year, result)
    create(year: year, result: result, exact_match: Population.exact_match?(year))
  end
end

class SearchHistory < ApplicationRecord
  def self.log(year, result)
    create(year: year, result: result)
  end
end

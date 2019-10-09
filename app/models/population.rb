class Population < ApplicationRecord

  def self.min_year
    Population.all.map(&:year).min.year
  end

  def self.max_year
    @max_year ||= Population.maximum("year").year
  end

  def self.get(year)
    year = year.to_i

    if year < min_year
      return 0
    elsif year >= max_year
      return Population.find_by_year(Date.new(max_year)).population
    else


      pop = nil
      until pop
        pop = Population.find_by_year(Date.new(year))
        year = year - 1
      end

      return pop.population if pop

      nil
    end
  end

end

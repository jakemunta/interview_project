class Population < ApplicationRecord
  MAX_YEAR = 2500

  def self.min_year
    @min_year ||= Population.minimum("year").year
  end

  def self.max_year
    @max_year ||= Population.maximum("year").year
  end

  def self.max_year_population
    @max_year_population ||= Population.find_by_year(Date.new(max_year)).population
  end

  def self.get(year)
    year = year.to_i

    if year < min_year
      return 0
    elsif year >= max_year
      return future_population_with_expected_growth(year)
    else
      return linear_population(year)
    end
  end

  def self.future_population_with_expected_growth(year, growth_rate=9)
    year = MAX_YEAR if year > MAX_YEAR
    max_year_population + (year - max_year)*growth_rate/100
  end

  def self.greater_year_population(year)
    @greater_year_population ||= Population.where("year > ?", Date.new(year)).first
  end

  def self.smaller_year_population(year)
    @smaller_year_population ||= Population.where("year <= ?", Date.new(year)).first
  end

  def self.linear_population(year)
    year_percent = calculate_year_percent(year)
    calculate_popultion_percent(year, year_percent)
  end

  def self.calculate_year_percent(year)
    greater_year = greater_year_population(year).year.year
    smaller_year = smaller_year_population(year).year.year
    ((year-smaller_year) * 100)/(greater_year - smaller_year)
  end

  def self.calculate_popultion_percent(year, year_percent)
    greater_population = greater_year_population(year).population
    smaller_population = smaller_year_population(year).population
    linear_difference  = (greater_population - smaller_population) * year_percent/100
    smaller_population + linear_difference
  end

end

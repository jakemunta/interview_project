class PopulationsController < ApplicationController
  def index
  end

  def show
    @year = params[:year].html_safe
    @population = Population.get(@year)
    log_search
  end

  private
  def log_search
    SearchHistory.log(@year, @population)
  end
end

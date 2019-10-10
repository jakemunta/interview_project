class SearchHistoriesController < ApplicationController
  def index
    @search_histories = SearchHistory.all
    @search_requests = Population.search_count_by_year
  end
end

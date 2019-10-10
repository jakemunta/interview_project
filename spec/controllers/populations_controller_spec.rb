require 'rails_helper'

RSpec.describe PopulationsController, type: :controller do
  render_views

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { year: "1900" }
      expect(response).to have_http_status(:success)
    end

    it "returns a population for a date" do
      year = 1900
      get :show, params: { year: year }
      expect(response.content_type).to eq "text/html"
      expect(response.body).to match /Population: #{Population.get(year)}/im
      expect(SearchHistory.last.year).to eq year
      expect(SearchHistory.last.exact_match).to eq true
      expect(SearchHistory.last.population_id).to eq Population.find_by_year(Date.new(year)).id
    end

    it "logs search history with exact match false" do
      year = 1904
      get :show, params: { year: year }
      expect(response.content_type).to eq "text/html"
      expect(response.body).to match /Population: #{Population.get(year)}/im
      expect(SearchHistory.last.exact_match).to eq nil
      expect(SearchHistory.last.population_id).to eq nil
    end

  end
end

require 'rails_helper'

RSpec.describe SearchHistoriesController, type: :controller do
  render_views

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to match /Population in result/im
    end
  end

end

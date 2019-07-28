require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  describe 'GET index' do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
    describe 'GET index' do
      it 'returns @restaurant' do
        Restaurant.create(:name=>"thai test")
        get :index
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(1)
        expect(parsed_response[0]["name"]).to eq("thai test")
        expect(parsed_response[0]["cuisine"]).to eq(nil)
      end
    end
  end
end

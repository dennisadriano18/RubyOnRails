require "rails_helper"

describe "TopScoreRanking API", type: :request do
  describe "POST /read" do
    it "record found" do
      FactoryBot.create(:player, name: "rspec2", score: 100, time_entry: "2021-05-14 14:06:00 UTC")
      FactoryBot.create(:player, name: "rspec3", score: 300, time_entry: "2021-05-14 14:06:00 UTC")
      FactoryBot.create(:player, name: "rspec4", score: 330, time_entry: "2021-05-14 14:06:00 UTC")
      post "/read", :params => {:playerlist=> ["rspec2", "rspec3","rspec4"], :summary=> true}, as: :json
      json = JSON.parse(response.body)
      average = json['average']
      top=json['top']
      low=json['low']
      expect(top).to eq(330)
      expect(low).to eq(100)
      expect(average).to eq(243)
    end
  end
end
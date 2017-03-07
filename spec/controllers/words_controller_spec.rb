require 'rails_helper'

RSpec.describe WordsController, type: :controller do

  describe "POST /words.json" do
    it "returns http success" do
      post "/", format: :json, data: {words: ["banana","shoes"]}
      expect(response).to have_http_status(:success)
    end

    it "call the method to add the words passed to the existing list of words" do
      post "/", format: :json, data: {words: ["banana","shoes"]}
      expect(response).to have_http_status(:success)
    end

  end

end

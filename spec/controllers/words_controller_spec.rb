require 'rails_helper'

RSpec.describe WordsController, type: :controller do

  describe "POST /words.json" do
    it "returns http success" do
      post :create, format: :json, words: ["banana","shoes"]
      expect(response).to have_http_status(:success)
    end

    it "call the method to add the words passed to the existing list of words" do
      expect(Word).to receive(:add_new_words).with(["banana","shoes"]).and_return(nil)
      post :create, format: :json, words: ["banana","shoes"]
    end

  end

end

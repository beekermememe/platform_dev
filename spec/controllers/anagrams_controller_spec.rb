require 'rails_helper'

RSpec.describe AnagramsController, type: :controller do

  describe "#Get - return anagrams" do
    it "returns http success" do
      get :get, word: "fast",format: :json
      expect(response).to have_http_status(:success)
    end

    it "expects to call the method to return anagrams for the word passed" do
      expect(Anagram).to receive(:find).with("dog",nil).and_return(["god","dog"])
      get :get, word: "dog",format: :json
    end

    it "expects to call the method to return anagrams for the word passed and a limit parameter" do
      expect(Anagram).to receive(:find).with("dog",2).and_return(["god","dog"])
      get :get, {word: "dog", limit: 2} ,format: :json
    end
    context "render the view here" do
      render_views
      it "should return a json array of anagrams" do
        expect(Anagram).to receive(:find).with("dog",nil).and_return(["god","dog"])
        get :get, word: "dog",format: :json
        data_returned = JSON.parse(response.body)
        expect(response.body).to eq("{\"anagrams\":[\"god\",\"dog\"]}")
      end
    end

  end

end

require 'rails_helper'

RSpec.describe AnagramsController, type: :controller do

  describe "#Get - return anagrams" do
    it "returns http success" do
      get :get, word: "fast",format: :json
      expect(response).to have_http_status(:success)
    end

    it "expects to call the method to return anagrams for the word passed" do
      expect(Anagram).to receive(:find).with("dog",20,nil).and_return(["god","dog"])
      get :get, word: "dog",format: :json
    end

    it "expects to call the method to return anagrams for the word passed and a limit parameter" do
      expect(Anagram).to receive(:find).with("dog",2,nil).and_return(["god","dog"])
      get :get, {word: "dog", limit: 2} ,format: :json
    end

    it "expects to call the method to return anagrams for the word passed and a limit parameter and to exclude propernouns" do
      expect(Anagram).to receive(:find).with("dog",2,false).and_return(["god","dog"])
      get :get, {word: "dog", limit: 2, include_proper_nouns: false } ,format: :json
    end

    it "expects to call the method to return anagrams for the word passed and a limit parameter and to include propernouns" do
      expect(Anagram).to receive(:find).with("dog",2,true).and_return(["god","dog"])
      get :get, {word: "dog", limit: 2, include_proper_nouns: true } ,format: :json
    end

    context "render the view here" do
      render_views
      it "should return a json array of anagrams" do
        expect(Anagram).to receive(:find).with("dog",20,nil).and_return(["god","dog"])
        get :get, word: "dog",format: :json
        data_returned = JSON.parse(response.body)
        expect(response.body).to eq("{\"anagrams\":[\"god\",\"dog\"]}")
      end
    end

  end

  describe "#Get get_max_occurring_anagrams - return anagrams" do
    it "should call the method to get the max anagrams" do
      expect(Anagram).to receive(:get_largest_groupings).and_return(["god","dog"])
      get :get_max_occurring_anagrams
    end
  end

end
